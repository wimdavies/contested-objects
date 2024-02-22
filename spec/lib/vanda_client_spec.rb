require 'clients/vanda_client'

describe VandaClient, :vcr do
  it "includes HTTParty" do
    expect(VandaClient.ancestors).to include HTTParty
  end

  it "sets the base_uri correctly" do
    expect(VandaClient.base_uri).to eq "https://api.vam.ac.uk/v2"
  end

  describe ".retrieve_single_object_record" do
    it "returns an HTTParty response object when 200 OK" do
      response = VandaClient.retrieve_single_object_record("O108443")
      expect(response.class).to eq HTTParty::Response
    end
  end
end
