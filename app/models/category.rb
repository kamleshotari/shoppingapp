class Category < ActiveRecord::Base
	validates :name, :presence => {:message => "Name can't be blank." }, 
						format: {with: /\A([^\d\W]|[-])*\z/ , message: 'Name cannot have any numbers or special characters'}

	validates	:description, :presence => true
						
	end


