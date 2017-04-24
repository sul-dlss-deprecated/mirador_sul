class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collections
  has_many :manifests, -> { distinct }, through: :collections # the User's library
  has_many :annotations

  after_create do |user|
    samples = JSON.parse(File.read('config/sample_data.json'))
    samples.deep_symbolize_keys!
    samples.values.each do |sample|
      sample[:user] = user
      CreateSampleData.new(sample).save
    end
  end
end
