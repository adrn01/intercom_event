require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates parameters' do
    it 'does not raise an error when params are valid' do
      expect { described_class.new(name: 'name', latitude: 1.1, longitude: 1.1, user_id: 1) }.not_to raise_error
      expect { described_class.new(name: 'name', latitude: '1.1', longitude: '1.1', user_id: '1') }.not_to raise_error
    end

    it 'raises error when no params' do
      expect { described_class.new }.to raise_error
    end

    it 'raises error when name is not provided' do
      expect do
        described_class.new(name: nil, latitude: 1.1, longitude: 1.1, user_id: 1)
      end.to raise_error('Name cannot be blank')
    end

    it 'raises error when user_id is not provided' do
      expect do
        described_class.new(name: 'name', latitude: 1.1, longitude: 1.1, user_id: nil)
      end.to raise_error('user_id must be supplied')
    end

    it 'raises error when latitude or longitude is not a number' do
      expect do
        described_class.new(name: 'name', latitude: 1.1, longitude: 'B', user_id: 1)
      end.to raise_error('Longitude must be provided and be a number')
      expect do
        described_class.new(name: 'name', latitude: 'A', longitude: 1.1, user_id: 1)
      end.to raise_error('Latitude must be provided and be a number')
    end

    it 'raises error when latitude or longitude is not provided' do
      expect do
        described_class.new(name: 'name', latitude: nil, longitude: 1.1, user_id: 1)
      end.to raise_error('Latitude must be provided and be a number')
      expect do
        described_class.new(name: 'name', latitude: 1.1, longitude: nil, user_id: 1)
      end.to raise_error('Longitude must be provided and be a number')
    end
  end

  describe 'distance method' do
    let(:user) { described_class.new(name: 'name', latitude: 1.1, longitude: 1.1, user_id: 1) }

    it 'uses sphere surface distance gem to calc distance' do
      expect(SphereSurfaceDistance::Calculator).to receive(:surface_distance_on_earth)
      user.distance_to(latitude: 0, longitude: 0)
    end
  end
end
