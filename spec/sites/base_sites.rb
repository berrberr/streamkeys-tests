require "spec_helper"

########################
# Missing Tests:
# 8tracks, deezer, earbits, jango, pandora, google music, rdio, seesu, spotify, stitcher, VK
########################

RSpec.describe "base site tests" do
  
  after(:all) do
    ErrLog.log.close
  end

  [ 
    {url: "http://americanfootball.bandcamp.com/album/american-football", overrides: {mute: true}},
    {url: "http://www.di.fm/ambient", overrides: {playNext: true, playPrev: true}},
    {url: "http://player.edge.ca", overrides: {playNext: true, playPrev: true}},
    {url: "http://www.grooveshark.com"},
    {url: "http://www.hypem.com"},
    {url: "http://www.iheart.com", overrides: {playPrev: true}},
    {url: "http://www.mixcloud.com", overrides: {playNext: true, playPrev: true}},
    {url: "http://www.myspace.com"},
    {url: "http://soundcloud.com/explore/ambient"},
    {url: "http://songza.com/listen/00s-number-1-hits-songza/", overrides: {playPrev: true}},
    {url: "http://www.slacker.com/", overrides: {mute: true}},
    {url: "http://www.thesixtyone.com/", overrides: {mute: true}}
  ].each do |site|

      context "Test for: #{site}" do
        it_behaves_like "a music site", (site[:overrides] || {}) do
          let(:url) { site[:url] }
        end
      end

  end
end
