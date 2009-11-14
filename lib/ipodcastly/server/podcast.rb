module Ipodcastly
  module Server
    class Podcast
      attr_reader :id, :title, :url

      include HTTParty
      base_uri '0.0.0.0:3000/api/v1'

      def initialize(id, title, url)
        @id = id
        @title = title
        @url = url
      end

      def episodes
        self.class.get("/episodes.json?podcast_id=#{id}").map { |e| Episode.new(e['id'], e['title'], e['position']) }
      end

      def self.all
        get('/podcasts.json').map { |p| new(p['id'], p['title'], p['url']) }
      end
    end
  end
end
