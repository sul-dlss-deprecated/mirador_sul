class AnnotationsController < ApplicationController
  protect_from_forgery except: [:index, :create, :delete]

  load_and_authorize_resource :workspace, except: [:show, :destroy]
  load_and_authorize_resource :annotation, through: :workspace, except: [:show, :index, :new, :create, :endpoint]
  load_and_authorize_resource :annotation, only: [:destroy]


  # GET /annotations
  def index
    if params[:format] == 'json' && params.fetch('uri', nil)
      canvas_uri = params[:uri]
      @annotations = @workspace.annotations.map do |d|
        annotation = JSON.parse(d[:data])
        if !annotation.nil? && canvas_in_annotation(annotation, canvas_uri)
          annotation
        end
      end.compact
    end
  end

  # GET /workspaces/:workspace_id/annotations/new
  def new
    @annotation = Annotation.new
  end

  # GET /annotations/:id
  def show
    get_annotation
  end

  # POST /workspaces/:workspace_id/annotations
  def create
    @annotation = @workspace.annotations.new(annotation_params)
    if @annotation.save
      redirect_to @annotation, notice: t('annotations.create')
    else
      redirect_to new_workspace_annotation_path, annotation: @annotation, alert: t('annotations.create_error')
    end
  end

  # DELETE /annotation/:id
  def destroy
    get_annotation
    @annotation.destroy
    redirect_to workspace_annotations_url, notice: t('annotations.destroy')
  end

  # GET /workspaces/:workspace_id/annotations/endpoint
  def endpoint; end

  private
    def get_annotation
      @annotation = Annotation.find_by_id(params[:id])
      if @annotation.nil?
        @annotation = Annotation.find_by(uuid: params[:id])
      end
      return @annotation
    end

    def annotation_params
      params.require(:annotation).permit(:uuid, :data)
    end

    def canvas_in_annotation(annotation, canvas_uri)
      on = annotation.fetch('on', nil)
      if !on.nil?
        on = [on] if !on.is_a?(Array)
        on.detect{ |entry| entry.fetch('full', nil) == canvas_uri }
      end
    end
end
