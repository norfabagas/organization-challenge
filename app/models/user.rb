class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :trackable, :confirmable

  ROLES = [
    ['Admin', 'admin'],
    ['Account Manager', 'account_manager'],
    ['Member', 'member']
  ]

  belongs_to :organization

  mount_uploader :avatar, AvatarUploader

  after_find :get_configuration
  after_create :create_configuration

  has_one   :configuration

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
    self.role == "member"
  end

  def account_manager?
    self.role == "account_manager"
  end

  def can_create_roles
    if self.admin?
      [ROLES[1], ROLES[2]]
    else
      [ROLES[2]]
    end
  end

  def current_theme
    self.configuration.theme
  end

  private 

  def create_configuration
    Configuration.create(
      theme: 'default',
      user_id: self.id
    )
  end

  def get_configuration
    if self.configuration.nil?
      create_configuration
    end
  end
end
