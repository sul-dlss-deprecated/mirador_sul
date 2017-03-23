class User < ApplicationRecord

  has_many :collections
  has_many :manifests, -> { distinct }, through: :collections # the User's library
end
