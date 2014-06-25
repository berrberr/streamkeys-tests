require "logger"

module ErrLog
  @logger = Logger.new("gshotkeys.log", "daily")
  @logger.level = Logger::WARN

  def self.log
    return @logger
  end

  def self.error(msg, name)
    @logger.error("\n#{name}\n#{msg}")
  end
end