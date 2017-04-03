class Collection < ApplicationRecord
  validates :name, presence: true

  belongs_to :user

  has_and_belongs_to_many :manifests
  accepts_nested_attributes_for :manifests
  has_many :workspaces

  def mirador_options
    {
      height: MiradorSul::Application.config.mirador_workspace_height,
      options: {
        data: manifest_urls.map { |manifest_url| { manifestUri: manifest_url } },
        mainMenuSettings: {
          userButtons: [
            {
              label: 'Save',
              iconClass: 'fa fa-lg fa-fw fa-floppy-o'
            }
          ]
        }
      }
    }
  end

  private

  def manifest_urls
    manifests.map(&:url)
  end
end
