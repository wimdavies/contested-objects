require "vanda_collection/wrapper"

describe VandaCollection::Wrapper, :vcr do
  describe ".find_by_system_number" do
    it "returns an OpenStruct for a valid existing system_number" do
      object_record = VandaCollection::Wrapper.find_by_system_number("O108443")
      expect(object_record).to be_an_instance_of OpenStruct
    end
  end
end
