# frozen_string_literal: true

require 'analyzer.rb'
require 'weblog.rb'
require 'output_writer.rb'

describe OutputWriter do
  before(:each) do
    injected = Weblog.new('sevenline.txt')
    @analyzer = Analyzer.new(injected)
    @output = OutputWriter.new(@analyzer)
  end
  it 'has a title in the NUV report when created' do
    @output.nuv_report
    fileobject = File.open('non_unique_views.txt')
    expect(fileobject.read).to include('Non-Unique Views')
  end
  it 'has a title in the UV report when created' do
    @output.uv_report
    fileobject = File.open('unique_views.txt')
    expect(fileobject.read).to include('Unique Views')
  end
end
