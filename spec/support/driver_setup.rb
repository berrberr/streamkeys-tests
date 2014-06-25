#require "selenium-webdriver"

#/Users/alexg/Documents/scripts/gshotkeys
#/Users/alex/gshotkeys
# module Driver
#   caps = Selenium::WebDriver::Remote::Capabilities.chrome(
#     "chromeOptions" => {
#       "args" => [ "--disable-web-security",
#        "--load-extension=/Users/alex/gshotkeys",
#        "--log-level=0"]
#     }, "loggingPrefs" => {"browser" => "ALL"})
#   @driver = Selenium::WebDriver.for :remote, url: "http://127.0.0.1:4444", desired_capabilities: caps
#   @wait = Selenium::WebDriver::Wait.new(:timeout => 10)

#   def self.get
#     return @driver
#   end

#   def self.quit
#     return @driver.quit
#   end
# end