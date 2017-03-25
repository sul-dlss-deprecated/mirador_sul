class Workspace < ApplicationRecord
  validates :name, presence: true

  belongs_to :collection

  serialize :data, JSON

  def data
    return collection.mirador_options.to_json if collection && new_record?
    super
  end

  def mirador_options
    JSON.parse(data).deep_symbolize_keys
  end
end
