module ActiveAdmin::ViewsHelper

  include Admin::NestedResourceHelper

  def resource_name
    resource.class.name.downcase
  end

end
