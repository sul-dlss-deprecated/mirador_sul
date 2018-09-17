# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :name, presence: true

  belongs_to :collection, counter_cache: true
  belongs_to :user, required: false

  serialize :data, JSON

  def data
    return {}.to_json if super.blank?

    super
  end
end
