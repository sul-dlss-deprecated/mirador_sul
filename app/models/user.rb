# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collections
  has_many :manifests, -> { distinct }, through: :collections # the User's library
  has_many :annotations

  after_create :create_sample_data

  def create_sample_data
    CreateSampleData.for_user(self)
  end
end
