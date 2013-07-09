class Vendor < ActiveRecord::Base

  # ASSOCIATIONS

  has_many :time_slots
  has_many :trucks
  has_many :locations, through: :time_slots

  # ATTRIBUTES

  attr_accessible :name, :contact_name, :phone, :email, :cuisine, :website

end
