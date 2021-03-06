class Product < ActiveRecord::Base
	include Paperclip::Glue
	# require 'elasticsearch/model'
	# include Elasticsearch::Model
 #  include Elasticsearch::Model::Callbacks
	belongs_to :category
	has_many :line_items
	has_many :product_instocks
	has_many :product_outstocks
	before_destroy :ensure_not_referenced_by_any_line_item
	has_many :order_items
	validates :title, :presence => {:message => "title can't be blank." }
						
	validates :price, :presence => true,
						:numericality => true
	has_attached_file :image, styles: { medium: "274x250>", thumb: "100x100>" }
	has_attached_file :view1, styles: { medium: "274x250>", thumb: "100x100>" }
	has_attached_file :view2, styles: { medium: "274x250>", thumb: "100x100>" }
	has_attached_file :view3, styles: { medium: "274x250>", thumb: "100x100>" }

  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	validates_attachment_content_type :view1, content_type: /\Aimage\/.*\Z/
  	validates_attachment_content_type :view2, content_type: /\Aimage\/.*\Z/
  	validates_attachment_content_type :view3, content_type: /\Aimage\/.*\Z/

  	validates	:category_id, :presence => true

	  def self.search(params)
	  	products = Product.all
	  	if params[:search].present?
		  	category = Category.where("name= ? or code= ?", params[:search], params[:search])
		  	if category.present?
		  		products = products.where("category_id IN (?)", category.last.id)
		  	else
		  		products = products.where("title LIKE ? OR price LIKE ?","%#{params[:search]}%","%#{params[:search]}%")
		  	end
		  	

		  end
	  	products

		end	
		def self.import(file)
			success = []
			fail = []
			main_result = []
	 		spreadsheet = open_spreadsheet(file)
	  	header = spreadsheet.row(1)
	  	(2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    product = Product.new
	    category = Category.find_by_name(row["Category"]) rescue nil
	    product.title = row["Name"]
	    product.price = row["Amount"]
	    product.description = row["Description"]
	    product.category_id = category.id rescue nil
	    product.code = row["Code"]
	    
	    if product.save 
	    	success << i
	    else
	    	fail << i
	    end
		  	
	  end
	  main_result << success
	  main_result << fail
	  main_result
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
			when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
			when '.xls' then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
			when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
			else raise "Unknown file type: #{file.original_filename}"
		end
	end	
	
	def self.get_total_stock(product)
		total_stock = 0
		total_instock = ProductInstock.where("product_id =?", product.id).collect{|p| p.product_quantity}.sum rescue 0
		total_outstock = ProductOutstock.where("product_id =?", product.id).collect{|p| p.product_quantity}.sum rescue 0
		total_stock = total_instock - total_outstock
		total_stock
	end
	

private
  
 
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors[:base] << "Line Items present"
      return false
    end
  end
			
end
