# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Annotation, type: :model do
  describe 'validations' do
    it 'requires uuid' do
      expect do
        described_class.create!(canvas: 'yolo')
      end.to raise_error(ActiveRecord::RecordInvalid, /Uuid/)
    end

    it 'requires canvas' do
      expect do
        described_class.create!(uuid: 'yolo')
      end.to raise_error(ActiveRecord::RecordInvalid, /Canvas/)
    end
  end
end
