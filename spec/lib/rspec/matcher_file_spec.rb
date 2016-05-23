RSpec.describe Rambo::RSpec::MatcherFile do
  let(:matchers_path) {
    File.expand_path("spec/support/matchers/rambo_matchers.rb")
  }

  before(:each) do
    FileUtils.mkdir_p("spec/support/matchers")
  end

  after(:each) do
    File.delete(matchers_path) rescue nil
    FileUtils.rmdir(File.expand_path("spec/support/matchers")) rescue nil # only delete dir if empty
    FileUtils.rmdir(File.expand_path("spec/support")) rescue nil
  end

  describe "#generate" do
    it "creates the file" do
      allow(subject).to receive(:file_already_exists?).and_return(false)
      subject.generate
      expect(File.exist? matchers_path).to be true
    end

    it "writes the contents to the file" do
      contents = File.read("lib/rspec/templates/matcher_file_template.erb")
      subject.generate
      expect(File.read(matchers_path)).to eql contents
    end
  end
end