# frozen_string_literal: true

require 'analyzer.rb'
require 'weblog.rb'

describe Analyzer do
  before(:each) do
    injected = Weblog.new('threeline.txt')
    @line_writer = Analyzer.new(injected)
  end
  describe 'build a dictionary of locations' do
    it 'can write a simple array of unique locations' do
      expect(@line_writer.dictionary[1]).to eq '/home'
    end
    it 'does not duplicate locations' do
      expect(@line_writer.dictionary.length).to eq 2
    end
  end
end

describe Analyzer do
  describe 'produce a simple count of urls' do
    it 'can count times a url appears' do
      injected = Weblog.new('threeline.txt')
      line_writer = Analyzer.new(injected)
      line_writer.non_unique_count
      expect(line_writer.nuc[1][1]).to eq 1
    end
    it'sorts values from big to small' do
      injected = Weblog.new('fourline.txt')
      line_writer = Analyzer.new(injected)
      line_writer.non_unique_count
      expect(line_writer.nuc[1][1]).to eq 1
    end
  end
end

describe Analyzer do
  before(:each) do
    injected = Weblog.new('fourline.txt')
    @line_writer = Analyzer.new(injected)
    @test_array = @line_writer.url_ip_match('/help_page/1')
  end
  describe 'it can produce a unique count of ips' do
    it 'can generate a table of ips' do
      expect(@test_array[2]).to eq '722.247.931.582'
    end
    it 'gets the right table length for ips!' do
      expect(@test_array.length).to eq 3
    end
    it 'can tell us the number of unique ips in an array' do
      number_of_ips = @line_writer.ip_count(@test_array)
      expect(number_of_ips).to eq 1
    end
  end
end

describe Analyzer do
  before(:each) do
    injected = Weblog.new('fourline.txt')
    @line_writer = Analyzer.new(injected)
    @uniq_array = @line_writer.unique_count
  end
  describe 'Unique count integration tests' do
    it 'returns 1 as as no of ips when we have duplicates' do
      expect(@uniq_array[0][1]).to eq 1
    end
    it 'returns 1 when we only have 1 ip listed!' do
      expect(@uniq_array[1][1]).to eq 1
    end
  end
end

describe Analyzer do
  it 'sorts results from largest to smallest' do
    injected = Weblog.new('sevenline.txt')
    line_writer = Analyzer.new(injected)
    uniq_array = line_writer.unique_count
    expect(uniq_array[0][1]). to eq 4
  end
end
