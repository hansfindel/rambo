module Rambo
  module RamlModels
    class Resource
      attr_reader :schema

      def initialize(raml_resource)
        @schema = raml_resource
      end

      def uri_partial
        schema.uri_partial
      end

      def http_methods
        @http_methods ||= schema.methods.map {|name, method| Rambo::RamlModels::Method.new(method) }
      end

      alias_method :to_s, :uri_partial
    end
  end
end
