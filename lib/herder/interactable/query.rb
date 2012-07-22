class Herder
  module Interactable
    class Query
      def initialize options
        params[:interactable_id] = options[:id] if options[:id]
        params[:interactable_type] = options[:type] if options[:type]
        newest
      end

      # this is used for lazy execution of the query
      def each &block
        query.each &block
      end

      def to_s
        query.to_s
      end

      def limit count
        params[:limit] = count
        self
      end

      def oldest
        order "created_at ASC"
      end

      def newest
        order "created_at DESC"
      end

      def set key
        params[:key] = key
        self
      end

      def to value
        params[:value] = value
        create
      end

      def state? key
        interaction = state(key)
        interaction && interaction.value.to_s == "true"
      end

      def state key
        limit 1
        newest
        states(key).first
      end

      def states key
        params[:key] = key
        query
      end

      protected

      attr_accessor :params

      def order by
        params[:order] = by
        self
      end

      def params
        @params ||= {}
      end

      def query
        @query ||= Interaction.where(params)
      end

      def method_missing(key, *args, &block)
        if key.to_s.ends_with? "?"
          key = key.to_s.gsub("?", "")
          state? key
        elsif key.to_s.ends_with? "="
          key = key.to_s.gsub("=", "")
          set(key).to(*args)
        elsif params[:limit] || params[:offset]
          states key
        else
          state(key)
        end
      end

      def create
        Interaction.create params.except(:limit, :offset, :order)
      end
    end
  end
end