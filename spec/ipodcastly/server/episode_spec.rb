require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipodcastly::Server::Episode do
  describe "#position" do
    it "shows position in seconds" do
      episode = Ipodcastly::Server::Episode.new(1, "Episode 1", 417120)
      episode.position.should == 417.12
    end
  end
end
