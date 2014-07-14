class User < ActiveRecord::Base

  has_many :packages, :dependent => :destroy
  has_many :requests, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ##Adding paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/assets/avatar.jpg",
                    :url  => "/assets/users/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 3.megabytes


  ##Adding Geocoder
  geocoded_by :home_address do |obj,results|
      if geo = results.first
          obj.latitude = geo.latitude
          obj.longitude = geo.longitude

      end
    #  obj.home_address = obj.home_address
  end
  reverse_geocoded_by :latitude, :longitude,
                      :address => :home_address



  after_validation :geocode, :if => lambda{ |obj| obj.home_address_changed? }
  after_validation :reverse_geocode, :if => lambda{ |obj| (obj.longitude_changed? or obj.latitude_changed?) \
                    and !obj.home_address_changed?  }


  ##Validations
  validates :username, presence: true,
            length: {minimum: 3}
  validates :mobile_number, presence: true,
            length: {within: 8..15}
  validates :home_address, presence: true


end
