#!/usr/bin/env ruby

require "json"
begin
  require "rest-client"
  require 'dotenv'
rescue LoadError
  puts "ERROR: rest-client and dotenv gems are required."
  exit 1
end

Dotenv.load
API = ENV["API"] || "https://cdn-manager-api.swisstxt.ch/api/v1"
LOAD = ARGV[0]
if LOAD == nil || ENV["KEY"] == nil || ENV["SERVICE"] == nil || ARGV[0].match(/^(-h|--help){1}$/)
  puts "Usage: \t\t send_load.rb LOAD"
  puts "-h/--help \t show this message"
  puts "Important: Configure KEY and SERVICE in a .env file"
  exit
end

begin
  puts "Send load (#{LOAD}) to #{ENV["SERVICE"].upcase}..."
  response = RestClient.post(
    "#{API}/services/#{ENV["SERVICE"]}/load/#{LOAD}",
    {key: ENV["KEY"]}
  )
  puts JSON.pretty_generate(JSON.parse(response))
rescue RestClient::ExceptionWithResponse => err
  puts "ERROR: #{err.response}"
end
