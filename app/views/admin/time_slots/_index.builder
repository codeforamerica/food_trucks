context.instance_eval do

  div class: "table_tools" do
    div class: "dropdown_menu", id: "batch_actions_selector" do
      link_to "Batch Actions", "#", class: "disabled dropdown_menu_button"
    end

    ul class: "scopes table_tools_segmented_control" do
      nested_resource_scope(:current) +
      nested_resource_scope(:upcoming) +
      nested_resource_scope(:expired)
    end
  end

  table_for(time_slots.by_scope(params[:scope]), :sortable => true, :class => 'index_table') do
    column :start_at
    column :finish_at
    column :location
    column :vendor
    column :actions do |time_slot|
      nested_resource_actions(resource, time_slot)
    end
  end

  div do
    nested_resource_paginated_collection(time_slots, nested_resource_name: :time_slots)
  end

end
