require 'rails_helper'

RSpec.describe "MuseumObjects", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/museum_objects/search"
      expect(response).to have_http_status(:success)
    end
  end

end
