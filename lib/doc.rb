# ODF Command Line Tools
#
module OCELOT

  # Methods shared by the various doc types
  class Doc

    # Generic doc creater
    def self.create path, extension, function
      path = path[-4..-1] != extension ? "#{path}#{extension}" : path
      @doc = function.call(path)
      path
    end

    # Generic doc loader
    #  note- this takes a klass and not a function like create() because
    #  apparently jruby can't pass a proc containing a function with arguments
    def self.load path, extension, klass
      path = path[-4..-1] != extension ? "#{path}#{extension}" : path
      begin
        # FIXME this check could be improved
        raise "Expecting an extension of the form `.XYZ`" unless extension.length == 4
        @doc = klass.load_document path
      rescue java.io.FileNotFoundException
        puts "#{path} does not exist."
        exit -1
      end
      path
    end

  end

 end
