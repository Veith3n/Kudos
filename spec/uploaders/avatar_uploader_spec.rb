require 'rails_helper'

RSpec.describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { AvatarUploader.new(user, :avatar) }
  let!(:zip_file) { 'spec/resources/sample.zip' }
  let!(:jpg_file) { 'spec/resources/sample.jpg' }

  it 'does not allow to update file with format not in whitelist' do
    expect { File.open(zip_file) { |f| uploader.store!(f) } }
      .to raise_error(CarrierWave::IntegrityError)
  end

  it 'does allow to update file with format in whitelist' do
    expect { File.open(jpg_file) { |f| uploader.store!(f) } }
      .not_to raise_error
  end
end
