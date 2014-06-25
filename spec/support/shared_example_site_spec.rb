require "selenium-webdriver"
require "rspec"

def run_sk_action(action)
  script = "document.dispatchEvent(new CustomEvent('streamkeys-test', {detail: '#{action}'}));"
  @driver.execute_script(script)
  return parse_log(action)
end

def parse_log(action)
  success_check = "STREAMKEYS-INFO: " + action
  fail_check = "STREAMKEYS-ERROR:"
  logs = @driver.manage.logs.get("browser")
  error_found = (logs.any? { |lg| lg.message.include? success_check } and logs.all? { |lg| not lg.message.include? fail_check })
  if(!error_found) then ErrLog.error("ACTION: #{action}\nLOGS:#{logs}", @driver.current_url) end

  return error_found
end

RSpec.shared_examples "a music site" do |overrides|
  before(:all) do
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      "chromeOptions" => {
        "args" => [ "--disable-web-security",
         "--load-extension=/Users/alex/gshotkeys",
         "--log-level=0"]
      }, "loggingPrefs" => {"browser" => "ALL"})
    @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  after(:all) do
    @driver.quit
  end

  context "player actions" do
    it "Loads site" do
      @driver.navigate.to url
    end

    it "Verify StreamKeys loads" do
      begin
        @wait.until { parse_log("SK content script loaded") }
      rescue
        @driver.quit
      end
    end

    unless(overrides[:playPause]) then 
      it "Verify play works" do
        expect(run_sk_action('playPause')).to be true
        # @driver.find_element(:css, "*")

        # @driver.action.key_down(:alt).key_down(:shift).send_keys("P")
        #               .key_up(:shift).key_up(:alt).perform
        # sleep 1

        # @driver.action.key_down(:alt).key_down(:shift).send_keys("p")
        #               .key_up(:shift).key_up(:alt).perform

        # @driver.action.send_keys [:command, :shift, "3"]
        # sleep 2
        # @driver.action.send_keys :command, :shift, "2"
        # @driver.action.send_keys :command, :shift, 1
      end
    end

    unless(overrides[:playPause]) then 
      it "Verify pause works" do
        expect(run_sk_action('playPause')).to be true
      end
    end
    
    unless(overrides[:playNext]) then
      it "Verify next track works" do
        expect(run_sk_action('playNext')).to be true
      end
    end
    
    unless(overrides[:playPrev]) then
      it "Verify previous track works" do
        expect(run_sk_action('playPrev')).to be true
      end
    end
    
    unless(overrides[:mute]) then
      it "Verify mute works" do
        expect(run_sk_action('mute')).to be true
      end
    end
  end
end
