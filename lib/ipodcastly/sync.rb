module Ipodcastly
  class Sync
    def self.start(options = {})
      puts "Syncing..."

      puts Client::Podcast.all.map{ |p| p.title }

      ## - Если я слушал какой-либо эпизод на Podcastly и не слушал его в iTunes, но
      ##  при этом в iTunes он у меня уже скачан - то в iTunes отметить время из
      ##  Podcastly.
      # Server::Podcast.all.each do |server_podcast|
      #   until client_podcast = Client::Podcast.find_by_title(server_podcast.title)
      #     Client::Podcast.subscribe(server_podcast.url)
      #     puts "Subscribing to #{server_podcast.url}"
      #   end
      #   puts "Updating #{server_podcast.url}"
      # 
      #   # Only episodes user listen
      #   server_podcast.episodes.each do |server_episode|
      #     next unless client_episode = client_podcast.episodes.detect { |client_episode| client_episode.title == server_episode.title }
      #     
      #     if client_episode.position.zero? && client_episode.updateable?
      #       client_episode.position = server_episode.position
      #       puts "Episode #{server_episode.title} positon updated to #{server_episode.position}"
      #     end
      #   end
      # end
    end # self.start
  end # Sync
end # Ipodcastly
