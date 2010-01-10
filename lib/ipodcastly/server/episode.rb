module Ipodcastly
  module Server
    class Episode
      include HTTParty
      base_uri 'http://podcastly.com/api/v1'
      default_params :api_key => Ipodcastly::Sync.api_key

      attr_reader :id, :podcast_id, :title, :position, :duration

      def initialize(id, podcast_id, title, position, duration = 0)
        @id = id
        @podcast_id = podcast_id
        @title = title
        @position = position
        @duration = duration
      end

      def to_param
        {
          :podcast_id => podcast_id,
          :episode => {
            :title => title,
            :position => position.to_i,
            :duration => duration.to_i
          }
        }
      end

      def save
        response = self.class.post("/episodes.json", :body => to_param)
        response.code == 200
      end
    end
  end
end
