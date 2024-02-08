require 'clients/vanda_client'

describe VandaClient, :vcr do
  it "includes HTTParty" do
    expect(VandaClient.ancestors).to include HTTParty
  end
end
