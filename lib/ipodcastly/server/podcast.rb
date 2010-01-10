module Ipodcastly
  module Server
    class Podcast
      include HTTParty
      base_uri 'http://podcastly.com/api/v1'
      default_params :api_key => Ipodcastly::Sync.api_key

      attr_reader :id, :title, :url

      def initialize(id, title, url)
        @id = id
        @title = title
        @url = url
      end

      def episodes
        response = self.class.get("/episodes.json?podcast_id=#{id}")

        if response.code == 200
          response.map { |e| Episode.new(e['id'], id, e['title'], e['position'], e['duration']) }
        else
          []
        end
      end

      def self.all
        response = get('/podcasts.json')

        if response.code == 200
          response.map { |p| new(p['id'], p['title'], p['url']) }
        else
          []
        end
      end

      def self.find_by_title(title)
        all.detect { |p| p.title == title }
      end
    end
  end
end
