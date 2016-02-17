require 'dotenv'
require 'screenshot_capture'

# Load Environment Variables
Dotenv.load

# Declare the Client instance passing in the authentication parameters
@client = ScreenshotLayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEYWORD'])

# Set the URL for the screenshot, we take a random URL from Wikipedia
url = 'https://en.wikipedia.org/wiki/Special:Random'

# We declare the options
options = ScreenshotLayer::CaptureOptions.new()

# We make the call to convert
response = @client.capture(url, options)

# If its a success, we print a message to the user
if ! response.nil?
  puts 'SUCCESS : Screenshot captured...' << response.length.to_s
end