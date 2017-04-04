class Workspace < ApplicationRecord
  validates :name, presence: true

  belongs_to :collection
  belongs_to :user

  has_many :annotations

  serialize :data, JSON

  def data
    return collection.mirador_options.to_json if collection && new_record?
    super
  end

  def mirador_options
    config = JSON.parse(data).deep_symbolize_keys
    config[:options].merge!({:annotationEndpoint => {
      :name => 'Storage',
      :module => 'Endpoint'
    }})
    config
  end
end
