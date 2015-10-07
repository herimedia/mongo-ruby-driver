# Copyright (C) 2015 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  class Cursor
    module Builder

      # Generates a specification for a get more command.
      #
      # @since 2.2.0
      class GetMoreCommand
        extend Forwardable

        # @return [ Cursor ] cursor The cursor.
        attr_reader :cursor

        def_delegators :@cursor, :batch_size, :collection, :coll_name, :database

        # Create the new builder.
        #
        # @example Create the builder.
        #   GetMoreCommand.new(cursor)
        #
        # @param [ Cursor ] cursor The cursor.
        #
        # @since 2.2.0
        def initialize(cursor)
          @cursor = cursor
        end

        # Get the specification.
        #
        # @example Get the specification.
        #   get_more_command.specification
        #
        # @return [ Hash ] The spec.
        #
        # @since 2.2.0
        def specification
          { selector: get_more_command, db_name: database.name }
        end

        private

        def get_more_command
          # @todo: :maxTimeMS
          spec = { :getMore => cursor.id, :collection => coll_name || collection.name }
          spec[:batchSize] = batch_size if batch_size
          spec
        end
      end
    end
  end
end
