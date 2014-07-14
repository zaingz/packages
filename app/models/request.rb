class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :package

  #Validations
  validates_presence_of :message, :user_id, :package_id
  #validates_uniqueness_of :package_id
  validate :unique_request?

  ##Adding scopes
  scope :my_pending_requests, lambda { |id| where(:accepted => false, user_id: id) }
  scope :my_accepted_requests, lambda { |id| where(:accepted => true, user_id: id) }
  scope :search_requests_for_me, lambda {|u_id,r_id| where(:user_id => u_id, id: r_id)}
  scope :authorize_requests_for, lambda {|id| where(:user_id => id) }

  private

  def unique_request?
    r = Request.where(:user_id => self.user_id, package_id: self.package_id)
    r.length > 1?false:true
  end

end
