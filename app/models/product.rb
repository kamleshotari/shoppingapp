class Product < ActiveRecord::Base
	include Paperclip::Glue
	has_attached_file :image, styles: { medium: "274x250>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
