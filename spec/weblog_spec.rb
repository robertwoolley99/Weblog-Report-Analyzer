# frozen_string_literal: true

require 'weblog.rb'

describe Weblog do
  it 'can read a line in the right format and split that between \
ip and filepath' do
  line_writer = Weblog.new('oneline.txt')
  expect(line_writer.data[0]).to eq '/help_page/1'
end
  it 'can read a line in the right format and split that between \
  ip and filepath' do
    line_writer = Weblog.new('oneline.txt')
    expect(line_writer.data[1]).to eq '722.247.931.582'
  end
  it 'can deal with multi line files' do
    line_writer = Weblog.new('twoline.txt')
    expect(line_writer.data[3]).to eq '061.945.150.735'
  end
end
