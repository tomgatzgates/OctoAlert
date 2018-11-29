class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: {
                      with: VALID_EMAIL_REGEX,
                      message: 'does not look like an email'
                    }

  has_secure_password
  validates :password, length: { minimum: 8 }

  def email=(value)
    self[:email] = value.strip.downcase
  end

  def remember!(token)
    update_column(:remember_digest, Encryptor.new(token).digest)
  end

  def forget!
    update_column(:remember_digest, nil)
  end

  def remebered?(token)
    Encryptor.new(token).matches?(remember_digest) if token
  end
end
