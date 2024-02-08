require 'clients/vanda_client'

describe VandaClient, :vcr do
  it "includes HTTParty" do
    expect(VandaClient.ancestors).to include HTTParty
  end

  it "sets the base_uri correctly" do
    expect(VandaClient.base_uri).to eq "https://api.vam.ac.uk/v2"
  end

  describe ".retrieve_object_record" do
    it "returns status 200 OK for a valid system_number" do
      response = VandaClient.retrieve_object_record("O108443")
      expect(response.success?).to eq true
    end
  end
end
