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
    collection = Collection.new(name: @name, description: @description, user: @user)
    collection.save
    @manifests.each do |url|
      manifest = Manifest.new(url: url)
      manifest.collections << collection
      manifest.user = @user
      manifest.save
    end
  end
end
