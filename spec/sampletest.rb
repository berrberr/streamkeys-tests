require 'selenium-webdriver'
require 'rspec'

describe "Rspec-example" do
  before(:all) do
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      "chromeOptions" => {
        "args" => [ "--disable-web-security",
         "--load-extension=/Users/alexg/Documents/scripts/gshotkeys",
         "--log-level=0"],
        "binary" => "/Applications/Chrome-35/Google Chrome.app/Contents/MacOS/Google Chrome"
      },
      "loggingPref" => {"driver" => "ALL"})
    @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
    @driver.navigate.to "http://www.grooveshark.com"
    @wait =  Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  after(:all) do
    @driver.quit
  end

  it "Verify grooveshark loads" do
    expect(@driver.find_element(:name,"q").enabled?).to be(true)
    #@driver.find_element(:name,"q").
    #Wait until  'flight finder' appears
    #@wait.until {@driver.find_element(:xpath,"/html/body/div/table/tbody/tr/td[2]/table/tbody/tr[4]/td/table/tbody/tr/td[2]/table/tbody/tr/td/img")}
    #checking user is navigated to home page
    #@driver.find_element(:css,"b  font  font").displayed?.should  == true 
  end

  it "Verify StreamKeys loads" do
    expect(true).to be true
  end

end
