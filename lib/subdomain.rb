class Subdomain
  def self.matches?(request)
    request.subdomain.present? && !(Account::RESERVED_SUBDOMAINS.include? request.subdomains.last)
  end
end