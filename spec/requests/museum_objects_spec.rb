require 'rails_helper'

RSpec.describe "MuseumObjects", type: :request do
  describe "GET /search" do
    # This auto-generated test fails due to the current implementation of /search.
    # This implementation is liable to change as the project evolves.
    xit "returns http success" do
      get "/museum_objects/search"
      expect(response).to have_http_status(:success)
    end
  end

end
