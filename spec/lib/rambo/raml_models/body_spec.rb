RSpec.describe Rambo::RamlModels::Body do
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:body) { raml.resources.first.http_methods.first.responses.first.bodies.first }

  subject { described_class.new(body) }

  describe "#content_type" do
    let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/foobar.raml") }

    it "returns the content type" do
      expect(subject.content_type).to eql body.content_type
    end
  end

  describe "#example" do
    context "when an example is given" do
      let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/foobar.raml") }

      it "returns an example" do
        expect(subject.example).to eql body.example
      end
    end

    context "when a schema is given" do
      let(:raml_file) { File.join(SPEC_DIR_ROOT, "../features/support/examples/raml/basic_raml_with_schema.raml") }

      it "returns generated JSON data" do
        expect(JSON.parse(subject.example)).to have_key "data"
      end
    end
  end
end
