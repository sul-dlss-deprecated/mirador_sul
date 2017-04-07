class Collection < ApplicationRecord
  validates :name, presence: true

  default_scope { order(created_at: :desc) }

  belongs_to :user

  has_and_belongs_to_many :manifests
  accepts_nested_attributes_for :manifests
  has_many :workspaces

  def mirador_options
    {
      id: 'viewer',
      buildPath: '/assets/',
      imagePath: '',
      i18nPath: '',
      data: manifest_urls.map { |manifest_url| { manifestUri: manifest_url } },
      openManifestsPage: true,
      mainMenuSettings: {
        userButtons: [
          {
            label: 'Save',
            iconClass: 'fa fa-lg fa-fw fa-floppy-o',
            attributes: { class: 'save' }
          }
        ]
      }
    }
  end

  private

  def manifest_urls
    manifests.map(&:url)
  end
end
