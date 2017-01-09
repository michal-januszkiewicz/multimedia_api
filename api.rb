require "rubygems"
require "sinatra/base"
require 'shellwords'
require 'pry'

class AndroidRemoteApi < Sinatra::Base
  get "/" do
    "online"
  end

  get "/volume" do
    bash("awk -F\"[][]\" '/dB/ { print $2 > \"volume\" }' <(amixer sget Master)")
    File.open("volume", "rb").read.chomp("%\n")
  end

  get "/volume/increase" do
    `amixer -D pulse sset Master 5%+`
  end

  post "/volume" do
    volume = params[:volume]
    `amixer -D pulse sset Master #{volume}%`
  end

  get "/brightness" do
    `redshift -p`
  end

  post "/brightness" do
    temperature = params[:temperature]
    brightness = params[:brightness].to_f / 100
    `redshift -b #{brightness} -O #{temperature}`
    "success"
  end


  private

  def bash(command)
    escaped_command = Shellwords.escape(command)
    system "bash -c #{escaped_command}"
  end
end
