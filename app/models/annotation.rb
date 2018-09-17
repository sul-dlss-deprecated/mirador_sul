# frozen_string_literal: true

##
# Annotation model
class Annotation < ApplicationRecord
  validates :uuid, presence: true
  validates :canvas, presence: true

  belongs_to :user, required: false

  serialize :data, JSON
end
