module Rambo
  module RSpec
    class ExampleGroup

      TEMPLATE_PATH = File.expand_path("../templates/example_group_template.erb", __FILE__)

      attr_reader :resource

      def initialize(resource)
        @resource = resource
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def create_fixture_files
        resource.http_methods.each do |method|
          if method.request_body
            path = File.expand_path("spec/support/examples/#{@resource.to_s.gsub(/\//, "")}_#{method.method}_request_body.json")
            File.write(path, request_body.example)
          end

          method.responses.each do |resp|
            resp.bodies.each do |body|
              if body.schema
                path = File.expand_path("spec/support/examples/#{@resource.to_s.gsub(/\//, "")}_#{method.method}_response_schema.json")
                File.write(path, body.example)
              else
                path = File.expand_path("spec/support/examples/#{@resource.to_s.gsub(/\//, "")}_#{method.method}_response_body.json")
                File.write(path, body.example)
              end
            end
          end
        end
      end

      def render
        create_fixture_files
        b = binding
        ERB.new(template, 0, "-", "@result").result(resource.instance_eval { b })
        @result
      end
    end
  end
end
