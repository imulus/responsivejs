require 'bundler'
Bundler.require

class App < Sinatra::Base
  set :public_folder, Proc.new { root }

  get "/" do
    File.read File.join('test', 'index.html')
  end
  
  get "/*" do |path|
    File.read File.join('test', "#{path}.html")    
  end
end
  