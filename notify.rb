require 'rubygems'
require 'libnotify'
require 'open-uri'
require 'openssl'
require 'nokogiri'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

loop do
  url = "https://sandbox.pagseguro.uol.com.br/"
  puts "checking #{url} - #{Time.now}"
  doc = Nokogiri::HTML(open(url))
  body_text = doc.css("body").text
  if !body_text.include?("No momento o ambiente de testes do PagSeguro está indisponível")
    Libnotify.show :summary => "#{Time.now}", :body => "Pagseguro sandbox disponível!!! :D", :timeout => 5
    break
  else
    Libnotify.show :summary => "#{Time.now}", :body => "Pagseguro insdisponível ainda :("
  end
  sleep 300
end
