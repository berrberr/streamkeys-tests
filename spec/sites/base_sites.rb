require "spec_helper"

RSpec.describe "base site tests" do

  after(:all) do
    Driver.quit
  end
  
  [ {url: "http://8tracks.com/lemmyxx/san-francisco-velvet", overrides: {playprev: true}},
    {url: "http://americanfootball.bandcamp.com/album/american-football", overrides: {mute: true}},
    {url: "http://www.grooveshark.com"},
    {url: "http://www.hypem.com"},
    {url: "http://www.iheart.com", overrides: {playprev: true}}].each do |site|

      describe site do
        it_behaves_like "a music site", (site[:overrides] || {}) do
          let(:url) { site[:url] }
        end
      end

  end
end

# after(:all) do
#   puts @driver.manage.logs.get("browser")
#   @driver.quit
# end