class Account < ActiveRecord::Base
  
 has_many :users
 has_one :owner
 
  validates_presence_of :subdomain
  validates_format_of :subdomain, :with => /^[A-Za-z0-9-]+$/, :multiline => true, :message => 'The subdomain can only contain alphanumeric characters and dashes.', :allow_blank => true
  validates_exclusion_of :subdomain, :in => %w( support blog www billing help api admin ), :message => "The subdomain <strong>{{value}}</strong> is reserved and unavailable."
  validates_uniqueness_of :subdomain, :case_sensitive => false
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)
 
 
  before_validation :downcase_subdomain

  RESERVED_SUBDOMAINS = %w(support blog www billing help api admin).freeze

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
  
end
