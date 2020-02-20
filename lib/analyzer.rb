# frozen_string_literal: true

# Analyzer class which will crunch the data injected from Weblog class.
class Analyzer
  attr_reader :dictionary, :nuc, :uc

  def initialize(objectname)
    @data = objectname.data
    build_dic
    non_unique_count
    unique_count
  end

  # loop through the @data file to build the dictionary
  # Use uniq to de-dupe it.
  # The +2 on n is because every other element is a URL.
  def build_dic
    duped_array = []
    n = 0
    until n == @data.length
      duped_array.push(@data[n])
      n += 2
    end
    @dictionary = duped_array.uniq
  end

  # build our non unique count as a 2D array then sort it
  # into descending order as per the brief.

  def non_unique_count
    xnuc = []
    @dictionary.each do |dict_line|
      count = @data.count(dict_line)
      xnuc.push([dict_line, count])
    end
    @nuc = reverse_sort(xnuc)
  end

  # Takes a URL and returns a list of all ips associated (including
  # duplicates) in 1D array format.

  def url_ip_match(url_argument)
    ip_table = []
    n = 0
    until n == @data.length
      ip_table.push(@data[n + 1]) if url_argument == @data[n]
      n += 2
    end
    ip_table
  end

  # Calculates number of unique IPs from a 1D of them.
  # Returns the number.

  def ip_count(input_array)
    deduped_array = input_array.uniq
    deduped_array.length
  end

  # Integration method - goes through the dictionary and builds
  # a 2d array of URL/unique IPs.

  def unique_count
    xuc = []
    @dictionary.each do |dict_line|
      list_of_ips_array = url_ip_match(dict_line)
      no_of_uniq_ips = ip_count(list_of_ips_array)
      xuc.push([dict_line, no_of_uniq_ips])
    end
    @uc = reverse_sort(xuc)
  end

  private

  def reverse_sort(input_array)
    input_array.sort { |url, count| count[1] <=> url[1] }
  end
end
