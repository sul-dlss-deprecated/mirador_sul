class Annotation < ApplicationRecord
  validates :uuid, presence: true

  belongs_to :workspace

  serialize :data, JSON
end
