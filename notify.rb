require 'rubygems'
require 'libnotify'
require 'open-uri'
require 'openssl'
require 'nokogiri'
require 'yaml'

config = YAML.load_file('config.yaml')

loop do
  url = config["url"]
  puts "checking #{url} - #{Time.now}"
  doc = Nokogiri::HTML(open(url))
  body_text = doc.css("body").text
  if !body_text.include?(config["text"])
    Libnotify.show :summary => "#{Time.now}", :body => config["success_message"], :timeout => 2
    break
  else
    Libnotify.show :summary => "#{Time.now}", :body => config["fail_message"]
  end
  sleep config["sleep"]
end
