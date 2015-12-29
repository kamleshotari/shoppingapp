class Product < ActiveRecord::Base
	include Paperclip::Glue
	validates :title, :presence => {:message => "title can't be blank." },
						format: {with: /\A([^\d\W]|[-])*\z/ , message: 'title cannot have any numbers or special characters'}
	validates :price, :presence => true,
						:numericality => true
	has_attached_file :image, styles: { medium: "274x250>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates	:category_id, :presence => true
  validates	:description, :presence => true	
end
