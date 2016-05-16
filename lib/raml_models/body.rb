require "json_test_data"

module Rambo
  module RamlModels
    class Body
      attr_reader :body

      def initialize(body)
        @body = body
      end

      def content_type
        body.content_type
      end

      def example
        @example ||= body.example || generate_from_schema(body.schema) || {}.to_json
      end

      private

      def generate_from_schema(schema)
        JSON.pretty_generate(JsonTestData.generate!(schema, ruby: true))
      end
    end
  end
end