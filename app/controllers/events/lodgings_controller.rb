class Events::LodgingsController < ApplicationController
  decorates_assigned :event

  def new
    authorize EventLodging
    @event = Event.find(params[:event_id])
  end

  def add
    event = Event.find(params[:event_id])
    if params.has_key?(:lodging_ids)
      lodging_ids = params[:lodging_ids].map { |id| {lodging_id: id} }
      event.event_lodgings.create(lodging_ids)
    else
      flash[:error] = 'No lodgings selected.'
    end
    redirect_to event_path(event)
  end

  def remove
    event = Event.find(params[:event_id])
    if params.has_key?(:event_lodging_ids)
      removed_lodgings = event.event_lodgings.find(params[:event_lodging_ids])
      event.event_lodgings.destroy(removed_lodgings)
    else
      flash[:error] = 'No lodgings selected.'
    end
    redirect_to event_lodgings_path(event)
  end

end
