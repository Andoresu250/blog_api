class User < ApplicationRecord
  include Users::Allowlist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
        #,:recoverable, :rememberable, :validatable

  attr_accessor :jwt

  validates :email, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true

end
