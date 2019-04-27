class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  rolify
  after_create :assign_default_role
  def username
    return self.email.split('@')[0]
  end
  def assign_default_role
    self.add_role(:regularuser) if self.roles.blank?
  end

  #Probando línea
  has_and_belongs_to_many :courses
  has_many :courses


end
