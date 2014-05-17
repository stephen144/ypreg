require 'spec_helper'

feature 'User manages a location' do

	let(:authed_user) {
		create_logged_in_user
		@location = create(:location)
	}		

	scenario ' by acessing the index' do
			visit locations_path(authed_user)
			expect(page).to have_content('Location')
			visit new_location_path
			expect(page).to have_content('New Location')
	end

	scenario '- creates a location successfully' do
		@location = create(:location)
		visit new_location_path
		expect {
			fill_in 'location[name]', with: @location.name
			fill_in 'location[description]', with: @location.description
			fill_in 'location[address1]', with: @location.address1
			fill_in 'location[city]', with: @location.city
			find("#location_state_abbrv").find(:xpath, "option[@value=\'#{@location.state_abbrv}\']").select_option
			fill_in 'location[zipcode]', with: @location.zipcode
			click_button 'Create Location'
		}.to change(Location, :count).by(1)
		expect(current_path).to eq events_path
		expect(page).to have_content('Locaction was successfully created.')
	end

	scenario ' - edits a location' do
		create(:location)
		@loc = Location.all.first
		visit edit_location_path(@loc)
		fill_in 'location[name]', with: 'My location'
		click_button 'Update Location'
	end
end

feature 'User destroys location' do
	before(:all) do
		@loc = create(:location)
	end

	scenario ' - successfully' do
		visit '/locations'
		expect{
			first(:link, 'Delete').click
	}.to change(Location, :count).by(-1)
	end
end
