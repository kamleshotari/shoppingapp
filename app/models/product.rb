class Product < ActiveRecord::Base
	include Paperclip::Glue
	belongs_to :category
	#attr_accessible :title, :price, :category_id
	validates :title, :presence => {:message => "title can't be blank." }
						
	validates :price, :presence => true,
						:numericality => true
	has_attached_file :image, styles: { medium: "274x250>", thumb: "100x100>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	validates	:category_id, :presence => true
  	
end
