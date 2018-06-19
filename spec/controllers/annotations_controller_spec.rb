require 'rails_helper'

RSpec.describe AnnotationsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      uuid: 'abc-123-do-re-mi',
      canvas: 'http://www.example.com/canvas',
      data: 'super cool anno data'
    }
  end
  let(:invalid_attributes) do
    {
      uuid: ''
    }
  end
  before { sign_in user }

  describe 'GET #index' do
    before do
      create_list(:annotation, 2, user: user)
      create(:annotation, user: user, canvas: 'http://www.example.com/bad')
      create(:annotation, canvas: 'http://www.example.com/hola')
    end

    it 'returns annotations that have the correct canvas uri' do
      get :index, params: { uri: 'http://www.example.com/hola', format: :json }
      expect(response.status).to eq 200
      expect(assigns(:annotations).length).to eq 2
    end
    it 'requires uri parameter' do
      expect { get :index, params: { format: :json } }.to raise_error ActionController::ParameterMissing, /uri/
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Annotation' do
        expect do
          post :create, params: { format: :json, annotation: valid_attributes }
        end.to change(Annotation, :count).by(1)
      end

      it 'assigns @annotation' do
        post :create, params: { format: :json, annotation: valid_attributes }
        expect(assigns(:annotation)).to be_a Annotation
      end

      it 'returns persited annotation data' do
        post :create, params: { format: :json, annotation: valid_attributes }
        expect(response.body).to eq 'super cool anno data'
      end
    end

    context 'with invalid parameters' do
      it 'responds with a 400' do
        post :create, params: { format: :json, annotation: invalid_attributes }
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq 'There was a problem creating the annotation.'
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:annotation) { Annotation.create! valid_attributes }
    before do
      annotation.user = user
      annotation.save
    end

    it 'destroys the requested annotation' do
      expect do
        delete :destroy, params: { format: :json, id: annotation.to_param }
      end.to change(Annotation, :count).by(-1)
    end

    it 'responds with accepted' do
      delete :destroy, params: { format: :json, id: annotation.to_param }
      expect(response).to have_http_status(:accepted)
      expect(response.body).to eq 'Annotation was successfully destroyed.'
    end
  end
end
