# frozen_string_literal: true

# Weblog class which will read data from the file and hold it in a 2D array.
class Weblog
  attr_reader :data
  def initialize(filename = 'webserver.log')
    fileobject = File.open(filename)
    @data = []
    File.foreach(filename) do |line|
      line.chomp!
      output = line.split
      @data.push(output.first)
      @data.push(output.last)
    end
    fileobject.close
  end
end
