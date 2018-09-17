# frozen_string_literal: true

class Collection < ApplicationRecord
  validates :name, presence: true

  default_scope { order(created_at: :desc) }

  belongs_to :user

  has_and_belongs_to_many :manifests
  accepts_nested_attributes_for :manifests
  has_many :workspaces
end
