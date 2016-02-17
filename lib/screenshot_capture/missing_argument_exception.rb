module ScreenshotLayer

  class MissingArgumentException < Exception

    attr_accessor :argument

    def initialize(argument)
      self.argument = argument
    end

  end

end