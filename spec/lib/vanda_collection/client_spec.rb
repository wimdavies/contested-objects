require "vanda_collection/client"

describe VandaCollection::Client, :vcr do
  it "includes HTTParty" do
    expect(VandaCollection::Client.ancestors).to include HTTParty
  end

  it "sets the base_uri correctly" do
    expect(VandaCollection::Client.base_uri).to eq "https://api.vam.ac.uk/v2"
  end

  describe ".retrieve_single_object_record" do
    it "returns a Hash for a valid existing record" do
      response = VandaCollection::Client.retrieve_single_object_record("O108443")
      expect(response).to be_an_instance_of Hash
    end

    it "returns parsed response for valid existing record (i.e. status 200 OK)" do
      response = VandaCollection::Client.retrieve_single_object_record("O108443")
      expect(response["record"]["systemNumber"]).to eq "O108443"
    end
    
    it "raises SystemNumberFormatError if passed an invalid system number" do
      expect { VandaCollection::Client.retrieve_single_object_record("bananas") }
        .to raise_error(VandaCollection::SystemNumberFormatError, "System number 'bananas' must be in valid format")
    end

    it "raises NotFoundError for valid, non-extant record" do
      expect { VandaCollection::Client.retrieve_single_object_record("O99999999") }
        .to raise_error(VandaCollection::NotFoundError, "Client received response status code 404")
    end
  end
end
