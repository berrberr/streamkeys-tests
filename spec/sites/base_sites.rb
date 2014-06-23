require "spec_helper"

[ {url: "http://8tracks.com/lemmyxx/san-francisco-velvet", overrides: {playprev: true}},
  {url: "http://americanfootball.bandcamp.com/album/american-football", overrides: {mute: true}},
  {url: "http://www.grooveshark.com", overrides: {playprev: true}}].each do |site|

    RSpec.describe site do
      it_behaves_like "a music site" do
        let(:url) { site[:url] }
        let(:overrides) { site[:overrides] }
      end
    end
end