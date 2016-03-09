class Address < ActiveRecord::Base
  belongs_to :user
  scope :default_active, -> { where(is_default: true).last }
  validates_length_of :zip_code, :maximum => 6
  validates :city, :state, :country, :address, :zip_code, :presence => true
end
