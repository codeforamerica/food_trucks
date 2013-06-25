class Api::LocationsController < Api::ApplicationController

  inherit_resources

  def search
    @q = Location.search(params[:q])
    @locations = @q.result(distinct: true)
    respond_with @locations
  end

end
