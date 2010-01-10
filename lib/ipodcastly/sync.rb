module Ipodcastly
  class Sync
    def self.api_key
      begin
        @api_key ||= YAML::load(File.open(File.join(ENV['HOME'], '.ipodcastly')))['api_key']
      rescue
        puts "API key is missing."
        exit
      end
    end

    # User listened an episode in Podcastly, he didn't listen it in the
    # iTunes, the episode already downloaded in the iTunes.
    def self.sync_itunes
      Server::Podcast.all.each do |server_podcast|
        until client_podcast = Client::Podcast.find_by_title(server_podcast.title)
          Client::Podcast.subscribe(server_podcast.url)
          puts "Subscribing to #{server_podcast.url}"
        end

        puts "\n+ Podcast \"#{server_podcast.title}\""

        # Only episodes the user listened
        server_podcast.episodes.each do |server_episode|
          next unless client_episode = client_podcast.episodes.detect { |client_episode| client_episode.title == server_episode.title }

          if client_episode.updateable?
            if !server_episode.duration.zero? && (server_episode.position == server_episode.duration)
              client_episode.mark_as_listened
            else
              client_episode.position = server_episode.position / 1000.0
            end

            puts "    + Episode \"#{server_episode.title}\" #{server_episode.duration.zero? ? "#{(server_episode.position / 1000)} sec." : "#{(server_episode.position * 100/server_episode.duration).to_i}%"}"
          end
        end
      end
    end # self.sync_itunes

    def self.sync_podcastly
      Client::Podcast.all.each do |client_podcast|
        unless server_podcast = Server::Podcast.find_by_title(client_podcast.title)
          puts "\n- Podcast \"#{client_podcast.title}\" skipped"
          next
        else
          puts "\n+ Podcast \"#{client_podcast.title}\""
        end

        client_podcast.episodes.each do |client_episode|
          if client_episode.listened? && client_episode.audio?
            if server_podcast.episodes.detect { |e| e.title == client_episode.title }
              puts "    - Episode \"#{client_episode.title}\" skipped"
              next
            end

            server_episode = Server::Episode.new(nil, server_podcast.id, client_episode.title, client_episode.position * 1000, client_episode.duration * 1000)

            if server_episode.save
              puts "    + Episode \"#{client_episode.title}\" #{(client_episode.position * 100/client_episode.duration).to_i}%"
            else
              puts "    ? Episode \"#{client_episode.title}\" failed"
            end
          end
        end
      end
    end # self.sync_podcastly

    def self.start(options = {})
      puts "Syncing Podcastly -> iTunes"
      sync_itunes

      puts "\nSyncing iTunes -> Podcastly"
      sync_podcastly
    end # self.start
  end # Sync
end # Ipodcastly
