class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_save :send_welcome_email
  has_many :addresses, :dependent => :destroy
  accepts_nested_attributes_for :addresses, :allow_destroy => true
  has_many :orders
  
  
  def is_admin?
  	self.is_admin
  end

  def send_welcome_email
  	if self.new_record?
  		SendEmail.send_email(self).deliver
  	end
  end
end
