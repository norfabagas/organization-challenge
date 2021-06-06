class Organization < ApplicationRecord
  
  has_many :users

  mount_uploader :logo, LogoUploader

  validates_presence_of :name,
                        :email,
                        :phone,
                        :logo,
                        :website

  validates_format_of :email,:with => Devise::email_regexp

  validates :name,
            length: {
              minimum: 6,
              maximum: 255
            }
  
  validates :email,
            uniqueness: true,
            length: {
              maximum: 255
            }

  validates :phone,
            numericality: true,
            uniqueness: true,
            length: { 
              minimum: 10, 
              maximum: 15
            }
  
  validates :website, 
            format: URI::regexp(%w[http https])

end
