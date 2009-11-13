module Ipodcastly
  module Client
    class Episode
      attr_reader :reference

      def initialize(reference)
        @reference = reference
      end

      def title
        @title ||= @reference.name.get
      end

      def duration
        @duration ||= @reference.duration.get
      end

      def position
        @position ||= @reference.bookmark.get
      end

      def position=(time)
        @position = time
        @reference.bookmark.set(time)
      end

      def updateable?
        @reference.enabled.get && @reference.played_count.get.zero?
      end

      def download
        @reference.download
      end
    end
  end
end
