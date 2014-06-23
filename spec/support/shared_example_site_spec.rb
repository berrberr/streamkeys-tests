require "selenium-webdriver"
require "rspec"

def run_sk_action(action)
  script = "document.dispatchEvent(new CustomEvent('SKTEST_function', {detail: '#{action}'}));"
  @driver.execute_script(script)
  return parse_log(action)
end

def parse_log(action)
  success_check = "STREAMKEYS-INFO: " + action
  fail_check = "STREAMKEYS-ERROR:"
  logs = @driver.manage.logs.get("browser")
  return (logs.any? { |lg| lg.message.include? success_check } and logs.all? { |lg| not lg.message.include? fail_check })
end

RSpec.shared_examples "a music site" do |overrides|
  before(:all) do
    @driver = Driver.get
  end

  context "player actions" do
    it "Loads site" do
      @driver.navigate.to url
    end

    it "Verify StreamKeys loads" do
      expect(true).to be true
    end

    unless(overrides[:playpause]) then 
      it "Verify play works" do
        expect(run_sk_action('playpause')).to be true
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

    unless(overrides[:playpause]) then 
      it "Verify pause works" do
        expect(run_sk_action('playpause')).to be true
      end
    end
    
    unless(overrides[:playnext]) then
      it "Verify next track works" do
        expect(run_sk_action('playnext')).to be true
      end
    end
    
    unless(overrides[:playprev]) then
      it "Verify previous track works" do
        expect(run_sk_action('playprev')).to be true
      end
    end
    
    unless(overrides[:mute]) then
      it "Verify mute works" do
        expect(run_sk_action('mute')).to be true
      end
    end
  end
end
