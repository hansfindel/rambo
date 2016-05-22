RSpec.describe Rambo::RSpec::ExampleGroup do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml)      { Raml::Parser.parse_file(raml_file) }
  let(:resource)  { Rambo::RamlModels::Resource.new(raml.resources.first) }

  subject         { Rambo::RSpec::ExampleGroup.new(resource) }

  describe "#render" do
    it "interpolates the correct values" do
      aggregate_failures do
        expect(subject.render).to include("describe \"#{raml.resources.first.methods.first.method.upcase}\" do")
        expect(subject.render).to include('describe "GET" do')
      end
    end

    it "does not include a request body" do
      expect(subject.render).not_to include("let(:request_body) do")
    end

    it "does not include headers" do
      expect(subject.render).not_to include("let(:headers) do")
    end

    context "when the route has a request body" do
      let(:raml_file) { File.expand_path("../../../support/basic_raml_with_post_route.raml", __FILE__) }

      it "adds a request body" do
        expect(subject.render).to include("let(:request_body) do")
      end

      it "does not include headers" do
        expect(subject.render).not_to include("let(:headers) do")
      end
    end

    context "when the route has request headers" do
      let(:raml_file) { File.expand_path("../../../support/post_with_request_headers.raml", __FILE__) }

      it "adds headers" do
        expect(subject.render).to include("let(:headers) do")
      end
    end
  end
end
