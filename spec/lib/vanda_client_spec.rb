require 'clients/vanda_client'

describe VandaClient, :vcr do
  it "includes HTTParty" do
    expect(VandaClient.ancestors).to include HTTParty
  end

  it "sets the base_uri correctly" do
    expect(VandaClient.base_uri).to eq "https://api.vam.ac.uk/v2"
  end

  describe ".retrieve_single_object_record" do
    it "returns an HTTParty response object for a valid system number" do
      response = VandaClient.retrieve_single_object_record("O108443")
      expect(response.class).to eq HTTParty::Response
    end
    
    it "raises custom ArgumentError if passed an invalid system number" do
      expect { VandaClient.retrieve_single_object_record("bananas") }
        .to raise_error(an_instance_of(ArgumentError).and having_attributes({"message" => "System number must be in valid format"}))
    end

    it "returns status 200 OK for valid existing record" do
      response = VandaClient.retrieve_single_object_record("O108443")
      expect(response.ok?).to eq true
    end

    it "returns status 404 for valid, non-extant record" do
      response = VandaClient.retrieve_single_object_record("O99999999")
      expect(response.not_found?).to eq true
    end
  end
end
