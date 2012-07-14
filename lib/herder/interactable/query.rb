class Herder
  module Interactable
    class Query

      def initialize options
        self.params = {}
        params[:interactable_id] = options[:id] if options[:id]
        params[:interactable_type] = options[:type] if options[:type]
      end

      def each
        yield query
      end

      def to_s
        query.to_s
      end

      def first count
        limit count
        order :created_at, :asc
        self
      end

      def last count
        limit count
        order :created_at, :desc
        self
      end

      def limit count
        params[:limit] = count
        params[:offset] = 0
        self
      end

      def order by, direction
        params[:order_by] = by
        params[:order_direction] = direction
        self
      end

      def state? key
        state(key) == "true"
      end

      def state key
        params[:key] = key
        limit 1
        query.first
      end

      protected

      attr_accessor :params

      def query
        @query ||= Interaction.where(params)
      end

      def method_missing(meffod, *args, &block)
        if meffod.to_s.ends_with? "?"
          meffod = meffod.to_s.gsub("?", "")
          state? meffod
        else
          state meffod
        end
      end
    end
  end
end