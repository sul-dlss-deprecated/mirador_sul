# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manifests', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  context 'an authorized user' do
    let(:collection) { create(:collection, user: user) }

    describe 'POST /collections/:collection_id/manifests' do
      it 'is allowed' do
        post collection_manifests_path(collection_id: collection.id, manifest: { url: 'ignore' })
        expect(response).to have_http_status(302)
        expect(Manifest.last.url).to eq 'ignore'
      end
    end

    describe 'DESTROY /collections/:collection_id/manifests/:manifest_id' do
      it 'is allowed' do
        manifest = create(:manifest, user: user)
        expect do
          delete collection_manifest_path(collection_id: collection.id, id: manifest.id)
        end.to change(Manifest, :count).by(-1)
      end
    end
  end

  context 'an anonymous user' do
    let(:collection) { create(:collection) }

    describe 'POST /collections/:collection_id/manifests' do
      it 'is not allowed' do
        expect do
          post collection_manifests_path(collection_id: collection.id, manifest: { url: 'ignore' })
        end.to raise_error(CanCan::AccessDenied)
      end
    end

    describe 'DESTROY /collections/:collection_id/manifests/:manifest_id' do
      it 'is not allowed' do
        expect do
          delete collection_manifest_path(collection_id: collection.id, id: create(:manifest).id)
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
