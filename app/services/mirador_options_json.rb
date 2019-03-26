# frozen_string_literal: true

##
# A plain ruby class that returns mirador configuration json given a
# workspace as well as a controller context (for things like user access)
class MiradorOptionsJson
  attr_reader :context, :workspace

  def initialize(context: nil, workspace:)
    @context = context || NullContext.new
    @workspace = workspace
  end

  delegate :collection, :data, :name, :new_record?, to: :workspace

  def to_json(*args)
    json = if parsed_data.blank?
             new_workspace_options
           else
             parsed_data
           end
    %i(merge_user_logo merge_user_button merge_annotation_endpoint).each_with_object(json) do |meth, hash|
      send(meth, hash)
    end.to_json(*args)
  end

  private

  def parsed_data
    JSON.parse(data)
  end

  def merge_user_logo(hash)
    hash['mainMenuSettings'] ||= {}
    hash['mainMenuSettings']['userLogo'] = { 'label' => name }
    hash
  end

  def merge_user_button(hash)
    if user_can_update_workspace?
      add_user_button(hash)
    else
      remove_user_button(hash)
    end
  end

  def add_user_button(hash)
    hash['mainMenuSettings'] ||= {}
    hash['mainMenuSettings']['userButtons'] ||= []
    return if config_includes_save_button?(hash)

    hash['mainMenuSettings']['userButtons'] << user_button_option
  end

  def remove_user_button(hash)
    return unless config_includes_save_button?(hash)

    hash['mainMenuSettings']['userButtons'].delete_if do |button_object|
      button_object['label'] == user_button_option[:label]
    end
  end

  def config_includes_save_button?(hash)
    return unless hash['mainMenuSettings'] && hash['mainMenuSettings']['userButtons']

    hash['mainMenuSettings']['userButtons'].any? do |button_object|
      button_object['label'] == user_button_option[:label]
    end
  end

  def merge_annotation_endpoint(hash)
    hash['annotationEndpoint'] = {
      name: 'Storage',
      module: 'Endpoint',
      options: {
        endpoint: context.annotations_path
      }
    }
  end

  def new_workspace_options
    {
      id: 'viewer',
      buildPath: '/assets/',
      imagePath: '',
      i18nPath: '',
      data: collection_manifest_urls.map { |manifest_url| { manifestUri: manifest_url } },
      openManifestsPage: true,
      mainMenuSettings: {}
    }
  end

  def user_button_option
    {
      label: 'Save',
      iconClass: 'fa fa-lg fa-fw fa-floppy-o',
      attributes: { class: 'save' }
    }
  end

  def collection_manifest_urls
    collection.manifests.map(&:url)
  end

  def user_can_update_workspace?
    context.can? :update, workspace
  end

  ##
  # Null object pattern for the injected controller context
  class NullContext
    def can?(*)
      false
    end

    def annotations_path(*)
      '/'
    end
  end
end
