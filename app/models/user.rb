class User < ActiveRecord::Base
  has_secure_password
  has_one :owner
  belongs_to :account
  
  default_scope { where(account_id: Account.current_id) }
  
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  
  ROLES = %w[client staff admin owner superuser]
  
  before_create  { generate_token(:auth_token) }
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def role_symbols
    roles.map(&:to_sym)
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  #To be used only when doing password reset or password is not set
  def generate_password    
      @char_map =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten     
      self.password = (0...10).map{ @char_map[rand(@char_map.length)] }.join
  end
  
end
