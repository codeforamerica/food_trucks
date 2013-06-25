class Api::VendorsController < Api::ApplicationController
  inherit_resources

  def search
    @q = Vendor.search(params[:q])
    @vendors = @q.result(distinct: true)
    respond_with @vendors
  end

end
