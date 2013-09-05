module ActiveAdmin::ViewsHelper

  def resource_name
    resource.class.name.downcase
  end

  def time_slot_actions(time_slot)
    [
      link_to("Show",  [ :admin, resource, time_slot ]),
      link_to("Edit", [ :edit, :admin, resource, time_slot ]),
      link_to("Destroy", [ :admin, resource, time_slot ], method: :delete)
    ].join(', ').html_safe
  end

  class TimeSlotPaginatedCollection < ActiveAdmin::Views::PaginatedCollection

    builder_method :time_slot_paginated_collection

    def build_download_format_links(formats = [:csv, :xml, :json])
      links = formats.collect do |format|
        link_to format.to_s.upcase, polymorphic_url([ :admin, resource, :time_slots ], {
          format: format
        }.merge(request.query_parameters.except(:commit, :format)))
      end
      div :class => "download_links" do
        text_node [I18n.t('active_admin.download'), links].flatten.join("&nbsp;").html_safe
      end
    end

  end

  def scope(scope)
    classes = []
    classes << :scope
    classes << scope
    classes << :selected if request.query_parameters[:scope].to_s == scope.to_s

    content_tag :li, class: classes.compact.join(" ") do
      link_to scope.to_s.capitalize, request.query_parameters.merge(scope: scope), class: "table_tools_button"
    end
  end

end
