module Ipodcastly
  class Sync
    # - Если я слушал какой-либо эпизод на Podcastly и не слушал его в iTunes, но
    #  при этом в iTunes он у меня уже скачан - то в iTunes отметить время из
    #  Podcastly.
    def self.sync_itunes
      Server::Podcast.all.each do |server_podcast|
        until client_podcast = Client::Podcast.find_by_title(server_podcast.title)
          Client::Podcast.subscribe(server_podcast.url)
          puts "Subscribing to #{server_podcast.url}"
        end
        puts "Updating #{server_podcast.url}"

        # Only episodes user listen
        server_podcast.episodes.each do |server_episode|
          next unless client_episode = client_podcast.episodes.detect { |client_episode| client_episode.title == server_episode.title }

          if client_episode.updateable?
            # client_episode.position = server_episode.position
            puts "Episode #{server_episode.title} positon updated to #{server_episode.position}"
          end
        end
      end
    end

    def self.sync_podcastly
      Client::Podcast.all.each do |client_podcast|
        client_podcast.episodes.each do |client_episode|
          if client_episode.listened? && client_episode.audio?
            puts client_episode.title
            puts "#{client_episode.position}/#{client_episode.duration}"
            puts "---"
          end
        end
      end
    end

    def self.start(options = {})
      puts "Syncing iTunes..."
      # sync_itunes

      puts "Syncing Podcastly..."
      sync_podcastly
    end # self.start
  end # Sync
end # Ipodcastly
