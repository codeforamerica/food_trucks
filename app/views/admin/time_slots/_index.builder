context.instance_eval do

  div class: "table_tools" do
    div class: "dropdown_menu", id: "batch_actions_selector" do
      link_to "Batch Actions", "#", class: "disabled dropdown_menu_button"
    end

    ul class: "scopes table_tools_segmented_control" do
      scope(:current) +
      scope(:upcoming) +
      scope(:expired)
    end
  end

  table_for(time_slots, :sortable => true, :class => 'index_table') do
    column :start_at
    column :finish_at
    column :location
    column :actions do |ts|
      time_slot_actions(ts)
    end
  end

  div do
    time_slot_paginated_collection(time_slots)
  end

end
