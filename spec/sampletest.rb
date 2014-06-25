require 'selenium-webdriver'
require 'rspec'

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

describe "Grooveshark suite" do
  before(:all) do
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      "chromeOptions" => {
        "args" => [ "--disable-web-security",
         "--load-extension=/Users/alexg/Documents/scripts/gshotkeys",
         "--log-level=0"],
        "binary" => "/Applications/Chrome-35/Google Chrome.app/Contents/MacOS/Google Chrome"
      }, "loggingPrefs" => {"browser" => "ALL"})
    #-2147483648
    #.manage.logs.get("browser")
    @driver = Selenium::WebDriver.for :remote, url: "http://127.0.0.1:4444", desired_capabilities: caps
    @driver.navigate.to "http://www.grooveshark.com"
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  after(:all) do
    puts @driver.manage.logs.get("browser")
    @driver.quit
  end

  it "Verify grooveshark loads" do
    #expect(@driver.find_element(:name, "q").enabled?).to be(true)
    #@driver.find_element(:name,"q").
    #Wait until  'flight finder' appears
    #@wait.until {@driver.find_element(:xpath,"/html/body/div/table/tbody/tr/td[2]/table/tbody/tr[4]/td/table/tbody/tr/td[2]/table/tbody/tr/td/img")}
    #checking user is navigated to home page
    #@driver.find_element(:css,"b  font  font").displayed?.should  == true 
  end

  it "Verify StreamKeys loads" do
    puts "is true true?"
    expect(true).to be true
  end

  context "Verify playPause works" do
    it "Verify play works" do
      expect(run_sk_action('play_pause')).to be true
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

    it "Verify pause works" do
      expect(run_sk_action('play_pause')).to be true
    end
  end

  it "Verify next track works" do
    expect(run_sk_action('play_next')).to be true
  end

  it "Verify previous track works" do
    expect(run_sk_action('play_prev')).to be true
  end

  it "Verify mute works" do
    expect(run_sk_action('mute')).to be true
  end
end
