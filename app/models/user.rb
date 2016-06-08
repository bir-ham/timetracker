class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :invoices
  
  validates :first_name, presence: true
  validates :second_name, presence: true
end
