class Category < ActiveRecord::Base
	has_many :products

	validates :name, :presence => {:message => "Name can't be blank." }, 
						uniqueness: true
	validates :code, uniqueness: true,
						:allow_blank => true


	validates	:description, :presence => true
					
	end


