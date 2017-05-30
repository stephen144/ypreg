class Events::LocalitiesController < ApplicationController
  decorates_assigned :all_locality_users, :event, :event_locality, :registrations, :users_not_registered

  def add
    authorize EventLocality
    @event = Event.find(params[:event_id])
  end

  def show
    @event_locality = EventLocality.find_by!(event_id: params[:event_id], locality_id: params[:id])
    authorize @event_locality

    @registrations = @event_locality.registrations.includes(:user)
    users_not_registered = @event_locality.locality.users.where.not(id: @event_locality.users.select(:id))
    @users_not_registered = policy_scope(users_not_registered)
    @tips_message = Payment.tips[:check_payment_instructions].html_safe
  end

  def new
    make_new(params[:event_id], params[:format])
  end

  def create
    make_new(params[:event_id], params[:locality_id])

    user_ids = params[:locality_user_ids]
    if user_ids.nil?
      flash.now[:error] = "No users were selected!"
      render 'new' and return
    end

    begin
      @event_locality.transaction(requires_new: true) do
        @event_locality.save!
        users = @all_locality_users.find(user_ids)
        users_hash = users.map { |user| {user: user} }
        @event_locality.registrations.create!(users_hash)
      end
    rescue ActiveRecord::RecordNotUnique
      retry
    rescue Exception => msg
      flash.now[:error] = "There was a problem saving these registrations: #{msg}"
      render 'new' and return
    end

    flash[:notice] = "Registrations added successfully."
    redirect_to event_localities_path(params[:event_id])
  end

  private

  def make_new(event_id, locality_id)
    @event_locality = EventLocality.new(event_id: event_id, locality_id: locality_id)
    authorize @event_locality
    all_locality_users = @event_locality.locality.users
    @all_locality_users = policy_scope(all_locality_users).by_name
  end
end
