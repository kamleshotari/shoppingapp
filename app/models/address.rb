class Address < ActiveRecord::Base
  belongs_to :user
  scope :default_active, -> { where(is_default: true).last }
end
