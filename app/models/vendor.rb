class Vendor < ActiveRecord::Base

  # ASSOCIATIONS

  has_many :time_slots, dependent: :destroy
  has_many :trucks, dependent: :destroy
  has_many :locations, through: :time_slots

  # ATTRIBUTES

  attr_accessible :name, :contact_name, :phone, :email, :cuisine, :website, :business_license_number

end
