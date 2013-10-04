class Api::TimeSlotsController < Api::ApplicationController

  inherit_resources

  belongs_to :location

  def index
    if params.include?(:location_id)
      index! do |format|
        format.json do
          respond_with collection.to_json(include: [ :vendor ])
        end
      end
    else
      @time_slots = TimeSlot.all
      respond_to do |format|
        format.json do
          respond_with collection.to_json(include: [ :vendor ])
        end
      end
    end
  end

  def search
    @q = TimeSlot.search(params[:q])
    @time_slots = @q.result(distinct: true)
    respond_with @time_slots
  end

end
