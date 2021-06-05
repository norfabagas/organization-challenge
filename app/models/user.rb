class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name,
                        :phone

  validates :name,
            length: {
              minimum: 6,
              maximum: 255
            }

  validates :phone,
            numericality: true,
            uniqueness: true,
            length: { 
              minimum: 10, 
              maximum: 15
            }


  def admin?
    self.role == "admin"
  end

  def member?
    self.role != "admin"
  end
end
