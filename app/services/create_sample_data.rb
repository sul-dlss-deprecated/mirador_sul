# frozen_string_literal: true

##
# A class that takes a user and creates two sample collections with
# manifests
class CreateSampleData
  def initialize(user:, name:, description:, manifests:)
    @user = user
    @name = name
    @description = description
    @manifests = manifests
  end

  def save
    collection = Collection.create(name: @name, description: @description, user: @user)
    @manifests.each do |url|
      Manifest.create(
        url: url,
        collections: [collection],
        user: @user
      )
    end
  end

  def self.for_user(user)
    samples = JSON.parse(File.read('config/sample_data.json'))
    samples.deep_symbolize_keys!
    samples.each_value do |sample|
      sample[:user] = user
      CreateSampleData.new(sample).save
    end
  end
end
