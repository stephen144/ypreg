desc "Create initial admin user for YPReg project"
namespace :ypreg do
  task create_admin: :environment do
    print "\n\n|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
    print "\nWelcome! This rake task will help you create an admin user to get started with YPReg.\n\n"
    print "First let's create your locality (e.g., if you meet with \nthe church in Anaheim, CA, create a locality for 'Anaheim, CA')\n"

    #output text colors
    warning_text_color = 93 #red
    success_text_color = 36 #cyan

    #text colorizing method
    def print_colored_text(text, color)
      print "\e[#{color}m#{text}\e[0m"
    end

    locality = {}
    input = nil

    until !input.nil? && input.size > 0
      puts "\n\nLocality name (e.g., 'Anaheim'): "
      print "> "

      input = STDIN.gets.chomp
      if input.size == 0
        print_colored_text("\n\nYour locality name can't be blank.\n\n",warning_text_color)
      else
        locality["city"] = input
      end 
    end

    input = nil

    until !input.nil? && input.size > 0
      puts "State Abbreviation ( e.g., 'CA'):"
      print "> "
      input = STDIN.gets.chomp
      if input.size == 0
        print_colored_text("The state abbreviation can't be blank.\n\n",warning_text_color)
      else
        locality["abbrv"] = input
      end
    end

    loc = Locality.where("city = ? and state_abbrv = ?", locality["city"].capitalize, locality["abbrv"].upcase).first

    if loc.presence
      locality["locality_id"] = loc.id
      notice = "This locality is already in the database...\n"
      print_colored_text(notice, warning_text_color)
    else
      new_locality = Locality.new(city: locality["city"].capitalize, state_abbrv: locality["abbrv"].upcase)
      if new_locality.save
        locality["locality_id"] = new_locality.id
        notice = "'#{Locality.first.city}, #{Locality.first.state_abbrv}' created successfully.\n"
        print_colored_text(notice, success_text_color)
      else
        notice = "Error creating the new locality."
        print_colored_text(notice, warning_text_color)
      end
    end

    print "\nNow, let's create your admin user account:"

    user = {}
    input = nil

    until !input.nil? && input.size > 0
      puts "\nEnter your full name: "
      print "> "
      input = STDIN.gets.chomp
      if input.size == 0
        print_colored_text("You didn't enter a name!", warning_text_color)
      else
        user["name"] = input
      end
    end

    input = nil
    until !input.nil? && input.size > 0
      puts "\nEnter your e-mail: "
      print "> "

      input = STDIN.gets.chomp
      if input.size == 0
        print_colored_text("You did not enter an e-mail address", warning_text_color)
      else
        user["email"] = input
      end
    end

    input = nil
    until !input.nil? && input.size > 0
      puts "\nEnter your password that is more than 6 characters long: "
      print "(hidden) > "

      input = STDIN.noecho(&:gets).chomp
      if input.size == 0
        print_colored_text("Password can't be blank", warning_text_color)
      else
        user["password"] = input
      end
    end

    if User.where("email = ?", user["email"]).first.presence
      notice = "\nThis user is already in the database...\n"
      print_colored_text(notice, warning_text_color)

    else
      new_user = User.new(name: user["name"].split.map(&:capitalize).join(' '), email: user["email"].downcase, password: user["password"], role: 'admin', locality_id: locality["locality_id"])
      binding.pry
      if new_user.save
        notice = "\n#{new_user.name} (#{new_user.email}) created successfully."
        print_colored_text(notice, success_text_color)
      else
        notice = "Error creating the new admin user."
        print_colored_text(notice, warning_text_color)
      end
    end
    print "\n\n\n"	
  end
end
