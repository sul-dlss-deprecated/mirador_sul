class Collection < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :manifests
  has_many :workspaces
end
