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
        @position ||= @reference.played_count.get > 0 ? duration : @reference.bookmark.get
      end

      def position=(time)
        @position = time
        @reference.bookmark.set(time)
      end

      def mark_as_listened
        @reference.played_count.set(1)
      end

      def enabled?
        @reference.enabled.get
      end

      def audio?
        @reference.video_kind.get == :none
      end

      def never_played?
        position.zero? && @reference.played_count.get.zero?
      end

      def updateable?
        enabled? && never_played?
      end

      def listened?
         enabled? && !never_played?
      end
    end
  end
end
