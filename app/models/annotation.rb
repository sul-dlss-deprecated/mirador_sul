##
# Annotation model
class Annotation < ApplicationRecord
  validates :uuid, presence: true
  validates :canvas, presence: true

  belongs_to :user

  serialize :data, JSON
end
