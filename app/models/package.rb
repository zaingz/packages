class Package < ActiveRecord::Base
  belongs_to :user
  has_many :requests

  ##Adding paperclip
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/assets/package.png",
                    :url  => "/assets/users/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 3.megabytes


  ##Adding geocoder
  reverse_geocoded_by :src_lat, :src_lon,
                      :address => :src_address
  after_validation :reverse_geocode, :if => lambda{ |obj| (obj.src_lat_changed? or obj.src_lon_changed?) }


  #Validations
  validates_presence_of :tittle, :description, :src_lat, :src_lon,
                        :dest_lat, :dest_lon, :user_id


##Adding scopes
  scope :my_delivered_packages, lambda { |id| where(:delivered => true, user_id: id) }
  scope :my_not_delivered_packages, lambda { |id| where(:delivered => false, user_id: id) }
  scope :packages_i_can_deliver, lambda {|id| where.not(:delivered => true, user_id: id) }
  scope :authorize_packages_for, lambda {|id| where(:user_id => id) }
  scope :search_package_for_me, lambda {|u_id,p_id| where(:user_id => u_id, id: p_id) }

end
