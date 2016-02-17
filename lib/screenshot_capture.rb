require 'uri'
require 'digest'
require 'fileutils'
require "httparty"
require "hashable"
require "screenshot_capture/version"

module ScreenshotLayer

  class Client

    include HTTParty

    base_uri 'api.screenshotlayer.com/api'

    def initialize(access_key, secret_keyword)

      if access_key.nil?
        raise ScreenshotLayer::MissingArgumentException.new 'access_key'
      end

      if secret_keyword.nil?
        raise ScreenshotLayer::MissingArgumentException.new 'secret_keyword'
      end

      @access_key = access_key
      @secret_keyword = secret_keyword

    end


    def capture(url, options = {})

      if url.nil?
        raise ScreenshotLayer::MissingArgumentException.new 'url'
        return
      end

      # Create a shallow copy so we don't manipulate the original reference
      query = options.dup

      # Generate the SecretKey for the request
      md5 = Digest::MD5.new
      md5.update url + @secret_keyword
      secret_key = md5.hexdigest

      # Populate the Query
      query.access_key = @access_key
      query.secret_key = secret_key
      query.url = URI.escape(url)

      # We then create the Request
      req = CaptureRequest.new(query)

      #  We create a Hash of the request so we can send it via HTTP
      req_dto = req.to_dh

      begin

        # We make the actual request
        res = self.class.get('/capture', req_dto)

        # We ensure that we tap the response so we can use the results
        res.inspect

        # If we have an export option passed in, we save it to local file system
        if options.filename.nil?

          # We just return the parsed binary response
          return res.parsed_response

        else

          begin

            # Ensure the path exists before we write
            FileUtils.mkdir_p(File.dirname(options.filename))

            File.open(options.filename, 'a+') do |file|

              file.write(res.body)

              result = {
                  success: true,
                  info: ScreenshotLayer::CaptureResponse::INFO_MESSAGE_SUCCESS_FILENAME,
                  file_name: options.filename
              }
              return result

            end

          end
        end


      rescue => e
        puts e.inspect
        return

      ensure
        # Clean Up

      end
    end
  end


  class CaptureRequest

    include Hashable

    attr_accessor :query

    def initialize(query = {})
      self.query = query;
    end

  end


  class CaptureOptions

    include Hashable

    attr_accessor :access_key
    attr_accessor :secret_key

    attr_accessor :url

    attr_accessor :fullpage
    attr_accessor :width
    attr_accessor :viewport
    attr_accessor :format
    attr_accessor :css_url
    attr_accessor :delay
    attr_accessor :ttl
    attr_accessor :force
    attr_accessor :placeholder
    attr_accessor :user_agent
    attr_accessor :accept_lang
    attr_accessor :export
    attr_accessor :filename

    def initialize()
      @query = nil
    end

  end


  class CaptureResponse

    SUCCESS_EXPR = 'success'
    INFO_EXPR = 'info'
    INFO_MESSAGE_SUCCESS_EXPORT = 'An attempt has been submitted to upload your screenshot to the given path. Please be aware that this process may take up to 1 minute to complete, and there will not be any system notifications in case your upload failed.'
    INFO_MESSAGE_SUCCESS_FILENAME = 'The Screenshot file has been saved to your local file system.'

    def bar
      SUCCESS_EXPR
      INFO_EXPR
      INFO_MESSAGE_SUCCESS_EXPORT
      INFO_MESSAGE_SUCCESS_FILENAME
    end

  end

end
