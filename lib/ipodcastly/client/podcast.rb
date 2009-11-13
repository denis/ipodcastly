module Ipodcastly
  module Client
    class Podcast
      attr_accessor :title

      @@itunes = Appscript.app('iTunes')
      @@podcasts = @@itunes.playlists.get.detect { |p| p.special_kind.get == :Podcasts }

      def initialize(title)
        @title = title
      end

      def episodes
        @@podcasts.tracks.get.select { |t| t.album.get == title }.map { |t| Episode.new(t) }
      end

      def self.all
        @@podcasts.tracks.get.map { |t| t.album.get }.uniq.map { |title| new(title) }
      end

      def self.find_by_title(title)
        all.detect { |p| p.title == title }
      end

      def self.subscribe(url)
        @@itunes.subscribe(url)
      end
    end
  end
end
