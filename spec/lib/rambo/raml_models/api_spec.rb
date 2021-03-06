RSpec.describe Rambo::RamlModels::Api do
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/secured_api.raml") }
  let(:raml)      { Raml::Parser.parse_file(raml_file) }

  subject { described_class.new(raml, { :token => "foobarbaz" }) }

  describe "#resources" do
    it "has the right number of resources" do
      expect(subject.resources.count).to eql 2
    end

    it "returns an array of Resource objects" do
      all_are_resources = subject.resources.all? {|resource| resource.is_a?(Rambo::RamlModels::Resource) }
      expect(all_are_resources).to be true
    end
  end

  describe "#title" do
    it "returns the API title from the RAML doc" do
      expect(subject.title).to eql raml.title
    end
  end

  describe "#security_schemes" do
    it "returns the security schemes" do
      expect(subject.security_schemes.all? {|scheme| scheme.is_a?(Rambo::RamlModels::SecurityScheme) }).to be true
    end
  end

  describe "headers" do
    it "incorporates API token headers" do
      expect(subject.headers.headers).to include({ "Api-Token" => "foobarbaz" })
    end
  end
end
