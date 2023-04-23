class User < ApplicationRecord
  include Users::Allowlist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
        #,:recoverable, :rememberable, :validatable

  attr_accessor :jwt

  has_many :friendships, class_name: 'Friendship'
  has_many :friends, through: :friendships

  validates :email, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true

  scope :search, -> (q) { where("LOWER(email) LIKE :q OR TRIM(REGEXP_REPLACE(LOWER(CONCAT(COALESCE(first_name, ''), ' ', COALESCE(last_name, ''))), '\s+', ' ', 'g')) LIKE :q", {q: "%#{q.downcase.squeeze(" ")}%"}) }

end
