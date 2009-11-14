require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipodcastly::Client::Episode do
  def mock_value(value)
    object = mock()
    object.stubs(:get).returns(value)
    object
  end

  def mock_episode(options = {})
    options = {
      :played_count => 0,
      :bookmark => 0.0,
      :duration => 12345.0
    }.merge(options)

    reference = mock()

    options.each { |k, v| reference.stubs(k).returns(mock_value(v)) }

    Ipodcastly::Client::Episode.new(reference)
  end

  describe "#position" do
    it "returns 0 if episode was never played before" do
      episode = mock_episode
      episode.position.should == 0.0
    end

    it "returns current bookmark value if episode is playing first time" do
      episode = mock_episode :bookmark => 169.0
      episode.position.should == 169.0
    end

    it "returns episode duration if episode was played once" do
      episode = mock_episode :played_count => 1
      episode.position.should == 12345.0
    end

    it "returns episode duration if episode is playing more than once" do
      episode = mock_episode :played_count => 5, :bookmark => 12.0
      episode.position.should == 12345.0
    end
  end
end
