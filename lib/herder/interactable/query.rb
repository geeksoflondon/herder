class Herder
  module Interactable
    class Query

      def initialize options
        self.params = {}
        params[:interactable_id] = options[:id] if options[:id]
        params[:interactable_type] = options[:type] if options[:type]
        order "created_at DESC"
      end

      def each
        yield query
      end

      def to_s
        query.to_s
      end

      def first count
        limit count
        order "created_at ASC"
        self
      end

      def last count
        limit count
        self
      end

      def limit count
        params[:limit] = count
        params[:offset] = 0
        self
      end

      def order by
        params[:order] = by
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
        interaction && interaction.value == "true"
      end

      def state key
        limit 1
        states(key).first
      end

      def states key
        params[:key] = key
        params[:limit] ||= 1
        params[:offset] ||= 0
        query
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
        elsif meffod.to_s.ends_with? "="
          meffod = meffod.to_s.gsub("=", "")
          set meffod
          to *args
        elsif params[:limit] || params[:offset]
          states meffod
        else
          state meffod
        end
      end

      def create
        Interaction.create params.except(:limit, :offset, :order)
      end
    end
  end
end