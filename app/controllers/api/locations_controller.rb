class Api::LocationsController < Api::ApplicationController

  inherit_resources

  def search
    @q = Location.search(params[:q])
    @locations = @q.result(distinct: true)

    respond_to do |format|
      format.json { render json: @locations }
      format.geojson do
        geojson = {
          type: "FeatureCollection",
          features: @locations.map(&:to_geojson)
        }

        render json: geojson
      end
    end
  end

end
