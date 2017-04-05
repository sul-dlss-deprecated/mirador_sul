class Workspace < ApplicationRecord
  validates :name, presence: true

  belongs_to :collection
  belongs_to :user

  serialize :data, JSON

  def data
    return collection.mirador_options.to_json if collection && new_record?
    super
  end

  # Proxying data through mirador_options
  # for consistency with Collection
  def mirador_options
    merge_user_logo(JSON.parse(data)).to_json
  end

  private

  def merge_user_logo(hash)
    hash['mainMenuSettings'] ||= {}
    hash['mainMenuSettings']['userLogo'] = { 'label' => name }
    hash
  end
end
