require 'rubygems'
require 'net/http'
require 'yaml'
require 'erb'

config = YAML.load(ERB.new(File.read("config.yaml")).result)

loop do
  uri = URI(config["url"])
  puts "checking #{uri} - #{Time.now}"
  res = Net::HTTP.get_response(uri)
  content = "#{Time.now} - #{uri} - #{res.code} #{res.msg} - HTTP VERSION: #{res.http_version}"
  File.open("#{uri.hostname}.log", 'a') { |file| file.write("#{content}\n") }
  puts content
  sleep config["sleep"]
end
