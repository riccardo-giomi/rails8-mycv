ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def assert_attribute_values(model, expected_attributes, ignore_timestamps: true)
      if ignore_timestamps
        expected_attributes.delete("created_at")
        expected_attributes.delete("updated_at")
      end

      expected_attributes.each do |name, expected|
        value = model.attributes[name.to_s]
        assert_equal expected, value,
          %(#{model.model_name}.#{name} unexpected value: "#{value}" != "#{expected}")
      end
    end
  end
end
