require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes route to #index' do
      expect(get: '/').to route_to('users#index')
    end

    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #import' do
      expect(post: '/users/import').to route_to('users#import')
    end

    it 'routes to #download' do
      expect(post: '/users/download').to route_to('users#download')
    end
  end
end
