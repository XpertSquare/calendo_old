class Account < ActiveRecord::Base
  
  has_many :users
  has_many :customer_profiles
  has_many :services
  has_many :activities
  has_one :owner
  
  has_many :business_hours
  has_many :holidays , :conditions => ["date >= '#{DateTime.now.beginning_of_year.strftime('%Y-%m-%d')}'::date"], :order => "DATE ASC"
  
  accepts_nested_attributes_for :business_hours , allow_destroy: true
  accepts_nested_attributes_for :holidays , allow_destroy: true
  
  validates_presence_of :name
  validates_presence_of :user_email, :user_name, :on => :create  
  validates_format_of :subdomain, :with => /^[A-Za-z0-9-]+$/, :multiline => true, :message => 'The subdomain can only contain alphanumeric characters and dashes.', :allow_blank => true
  validates_exclusion_of :subdomain, :in => %w( support blog www billing help api admin ), :message => "The subdomain <strong>{{value}}</strong> is reserved and unavailable."
  validates_uniqueness_of :subdomain, :case_sensitive => false
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name), :if => :time_zone
 
  validate :business_hours_valid

  
 
  before_validation :downcase_subdomain

  RESERVED_SUBDOMAINS = %w(support blog www billing help api admin en fr ro it es de hu).freeze

  def user_name
    @user_name
  end
  def user_name=(val)
    @user_name = val
  end

  def user_email
    @user_email
  end
  def user_email=(val)
    @user_email = val
  end


  def self.current_id=(id)
    Thread.current[:account_id] = id
  end
    
  def self.current_id
    Thread.current[:account_id]
  end
  
  def self.is_reserved_subdomain(subdomain)
    RESERVED_SUBDOMAINS.include? subdomain
  end   

  protected

  def downcase_subdomain
    self.subdomain.downcase! if attribute_present?("subdomain")
  end
  
  private 
  def business_hours_valid
    self.business_hours.each do |bh|
      if Time.parse(bh.open_time)>= Time.parse(bh.close_time)
        errors.add(:business_hours, "open time must be earlier than the close time for: " + bh.day.to_s.humanize)
      end  
    end
    
  end 
end
