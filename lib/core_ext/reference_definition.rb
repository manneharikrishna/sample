require 'active_record/connection_adapters/abstract/schema_definitions.rb'

module ActiveRecord
  module ConnectionAdapters
    class ReferenceDefinition # :nodoc:
      def initialize(
        name,
          polymorphic: false,
          index: true,
          foreign_key: false,
          type: :integer,
          **options
      )
        @name = name
        @polymorphic = polymorphic
        @index = index
        @foreign_key = foreign_key
        @type = type
        @options = options

        if polymorphic && foreign_key
          raise ArgumentError, "Cannot add a foreign key to a polymorphic relation"
        end
      end
    end
  end
end
