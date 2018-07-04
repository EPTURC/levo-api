class User < ApplicationRecord
  has_secure_password
  
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/

  def as_json(options={})
    super(except: :password_digest)
  end

  def is_admin?
    self.is_admin
  end
end
