require 'securerandom'
require 'json'
require 'dotenv'
require 'spec_helper'
require 'screenshot_capture'


# Load Environment Variables
Dotenv.load


RSpec.configure do |c|
  # declare an exclusion filter
  c.filter_run_excluding :ci => ENV['CONTEXT'] == 'travis-ci'
end


describe ScreenshotLayer do


  it 'has a version number' do
    expect(ScreenshotLayer::VERSION).not_to be nil
  end


  it 'capture (simple)' do

    begin

      # Declare the Client instance passing in the authentication parameters
      @client = ScreenshotLayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEYWORD'])

      # Set the URL to Capture, we take a random URL from Wikipedia
      url = 'https://en.wikipedia.org/wiki/Special:Random'

      # We declare the options
      options = ScreenshotLayer::CaptureOptions.new()

      # We make the call to convert
      response = @client.capture(url, options)

      # First we check the response
      expect(response).not_to be nil

    rescue => e
      puts e.inspect

    end

  end


  it 'capture (simple) w. export', :ci => true do

    begin

      # Declare the Client instance passing in the authentication parameters
      @client = ScreenshotLayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEYWORD'])

      # Set the URL to get as PDF, we take a random URL from Wikipedia
      url = 'https://en.wikipedia.org/wiki/Special:Random'

      # We declare the options
      options = ScreenshotLayer::CaptureOptions.new()

      # We then set the export option
      options.export = ENV['EXPORT_FTP']

      # We make the call to convert
      response = @client.capture(url, options)

      # First we check the response
      expect(response).not_to be nil

      # Convert to JSON since we expect it to be a message due to Export option
      result = JSON.parse(JSON(response))

      # Then we check if the file exists has been successfully written to disk
      expect(result[ScreenshotLayer::CaptureResponse::SUCCESS_EXPR]).to be true
      expect(result[ScreenshotLayer::CaptureResponse::INFO_EXPR]).to eql(ScreenshotLayer::CaptureResponse::INFO_MESSAGE_SUCCESS_EXPORT)


    rescue => e
      puts e.inspect

    end

  end


  it 'capture (simple) w. filename', :ci => true do

    begin

      # Declare the Client instance passing in the authentication parameters
      @client = ScreenshotLayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEYWORD'])

      # Set the URL to get as PDF, we take a random URL from Wikipedia
      url = 'https://en.wikipedia.org/wiki/Special:Random'

      # We declare the options
      options = ScreenshotLayer::CaptureOptions.new()

      # We then set the filename option
      options.filename = File.join('tmp', SecureRandom.uuid() +'.pdf')

      # We make the call to convert
      response = @client.capture(url, options)

      # First we check the response
      expect(response).not_to be nil

      # Convert to JSON since we expect it to be a message due to Export option
      result = JSON.parse(JSON(response))

      # Then we check if the file exists has been successfully written to disk
      expect(result[ScreenshotLayer::CaptureResponse::SUCCESS_EXPR]).to be true
      expect(result[ScreenshotLayer::CaptureResponse::INFO_EXPR]).to eql(ScreenshotLayer::CaptureResponse::INFO_MESSAGE_SUCCESS_FILENAME)

      # Then we check if the file exists has been successfully written to disk
      file_exists = File.exist?(options.filename)
      expect(file_exists).to be true

    rescue => e
      puts e.inspect

    ensure
      # Clean up after the test and remove the file from disk
      File.delete(options.filename);

    end

  end

end




