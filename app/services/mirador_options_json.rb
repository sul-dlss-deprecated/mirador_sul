##
# A plain ruby class that returns mirador configuration json given a
# workspace as well as a controller context (for things like user access)
class MiradorOptionsJson
  attr_reader :context, :workspace

  def initialize(context: NullContext, workspace:)
    @context = context
    @workspace = workspace
  end

  delegate :collection, :data, :name, :new_record?, to: :workspace

  def to_json
    return new_workspace_options.to_json if data.blank?
    merge_user_logo(JSON.parse(workspace.data)).to_json
  end

  private

  def merge_user_logo(hash)
    hash['mainMenuSettings'] ||= {}
    hash['mainMenuSettings']['userLogo'] = { 'label' => name }
    hash
  end

  def new_workspace_options
    {
      id: 'viewer',
      buildPath: '/assets/',
      imagePath: '',
      i18nPath: '',
      data: collection_manifest_urls.map { |manifest_url| { manifestUri: manifest_url } },
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

  def collection_manifest_urls
    collection.manifests.map(&:url)
  end

  class NullContext
  end
end
