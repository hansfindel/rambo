Feature: Create specs from RAML

  The example files can be found in features/support/examples

  Scenario: Generate specs from a simple RAML file
    Given a file named "foo.raml" like "empty_raml.raml"
    When I run `rambo foo.raml`
    Then the directory "spec/contract" should exist
    And the file "spec/contract/foo_spec.rb" should exist
    And the file "spec/rambo_helper.rb" should exist
    And the file "spec/rambo_helper.rb" should contain:
      """
      require "spec_helper"
      """
    And the file "spec/contract/foo_spec.rb" should be like "empty_spec.rb.example"
    And the exit status should be 0
