class Encryptor
  attr_reader :token

  def initialize(token = nil)
    @token = token || SecureRandom.urlsafe_base64
  end

  def digest(cost = nil)
    @digest ||= BCrypt::Password.create(@token, cost: cost || default_cost)
  end

  def matches?(digest)
    BCrypt::Password.new(digest).is_password?(@token)
  end

  private

  def default_cost
    BCrypt::Engine.cost
  end
end
