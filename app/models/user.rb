# User model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :registrations
  has_many :events, through: :registrations
  belongs_to :locality

  # Constants
  GENDER = %w(Brother Sister)
  USER_ROLE = %w(admin scyp ycat loc_contact hosp_contact trainee speaking_brother supporting_brother helper yp user guest)

  # scopes
  def self.not_contact_persons
    contact_person_ids = Lodging.where.not(contact_person: nil).pluck(:contact_person_id)
    User.where.not(id: contact_person_ids)
  end

   # Interface
  def role?(base_role)
    role == base_role.to_s
  end

  def age
    if birthday.nil?
      nil
    else
      ((Date.today - birthday).to_i / 365.25).to_i
    end
  end

  def locality_city
    if locality.city.nil?
      ""
    else
      locality.city
    end
  end

  def registration(event)
    Registration.where(user: self, event: event)[0]
  end

  def hospitality_registration_assignment(event)
    HospitalityRegistrationAssignment.where(registration: registration(event))[0]
  end

  def assigned_hospitality(event)
    hra = hospitality_registration_assignment(event)
    if hra.nil?
      nil
    else
      hra.hospitality
    end
  end

  # private?
  def hospitality(event)
    reg = registration(event)
    if reg.nil?
      nil
    else
      Hospitality.where(event: event, locality: locality)[0]
    end
  end
end
