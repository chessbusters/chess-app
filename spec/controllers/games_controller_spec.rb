require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index action' do
    it 'should successfully show the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#show action' do
    it 'should successfully display a game if the game is found' do
      game = FactoryGirl.create(:game)
      user = FactoryGirl.create(:user)
      sign_in user
      get :show, id: game.id
      expect(response).to have_http_status(:success)
    end
  end
end
