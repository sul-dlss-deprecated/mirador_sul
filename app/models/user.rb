class User < ApplicationRecord
  has_secure_password # TODO: only if source == 'local'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true # used for login
  validates :source, presence: true, inclusion: { in: %w(sunetid local) } # database source

  has_many :collections
  has_many :manifests, -> { distinct }, through: :collections # the User's library
end
