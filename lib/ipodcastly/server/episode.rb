module Ipodcastly
  module Server
    class Episode
      attr_reader :id, :title

      def initialize(id, title, position)
        @id = id
        @title = title
        @position = position
      end

      def position
        @position / 1000.0
      end
    end
  end
end
