require 'rails_helper'

RSpec.describe CollectionsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      name: 'Super amazing collection! 😎',
      user: user
    }
  end

  let(:invalid_attributes) { { name: nil, user: user } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all collections as @collections' do
      collection = Collection.create! valid_attributes
      get :index, params: {}
      expect(assigns(:collections)).to eq([collection])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested collection as @collection' do
      collection = Collection.create! valid_attributes
      get :show, params: {id: collection.to_param}
      expect(assigns(:collection)).to eq(collection)
    end
  end

  describe 'GET #new' do
    it 'assigns a new collection as @collection' do
      get :new, params: {}
      expect(assigns(:collection)).to be_a_new(Collection)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested collection as @collection' do
      collection = Collection.create! valid_attributes
      get :edit, params: {id: collection.to_param}
      expect(assigns(:collection)).to eq(collection)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Collection' do
        expect {
          post :create, params: {collection: valid_attributes}
        }.to change(Collection, :count).by(1)
      end

      it 'assigns a newly created collection as @collection' do
        post :create, params: {collection: valid_attributes}
        expect(assigns(:collection)).to be_a(Collection)
        expect(assigns(:collection)).to be_persisted
      end

      it 'redirects to the created collection' do
        post :create, params: {collection: valid_attributes}
        expect(response).to redirect_to(Collection.last)
      end
    end

    context 'with invalid params' do
      it 'renders the new page' do
        post :create, params: { collection: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'holla' } }

      it 'updates the requested collection' do
        collection = Collection.create! valid_attributes
        put :update, params: {id: collection.to_param, collection: new_attributes}
        # collection.reload
        expect(assigns(:collection).name).to eq 'holla'
      end

      it 'assigns the requested collection as @collection' do
        collection = Collection.create! valid_attributes
        put :update, params: {id: collection.to_param, collection: valid_attributes}
        expect(assigns(:collection)).to eq(collection)
      end

      it 'redirects to the collection' do
        collection = Collection.create! valid_attributes
        put :update, params: {id: collection.to_param, collection: valid_attributes}
        expect(response).to redirect_to(collection)
      end
    end

    context 'with invalid params' do
      it 'renders  the edit page' do
        collection = Collection.create! valid_attributes
        put :update, params: { id: collection.to_param, collection: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested collection' do
      collection = Collection.create! valid_attributes
      expect {
        delete :destroy, params: {id: collection.to_param}
      }.to change(Collection, :count).by(-1)
    end

    it 'redirects to the collections list' do
      collection = Collection.create! valid_attributes
      delete :destroy, params: {id: collection.to_param}
      expect(response).to redirect_to(collections_url)
    end
  end

end
