class Api::TimeSlotsController < Api::ApplicationController

  inherit_resources
  belongs_to :location

  def index
    index! do |format|
      format.json do
        respond_with collection.to_json(include: [ :vendor ])
      end
    end
  end

end
