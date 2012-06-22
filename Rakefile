require 'rb-fsevent'
require 'coyote/rake'
require 'appscript'
include Appscript

multitask :start => [ 'watch', 'specs:watch', 'reload' ]

coyote do |config|
  config.input  = "src/responsive.coffee"
  config.output = "lib/responsive.js"
end

namespace :specs do
  coyote do |config|
    config.input  = "spec/specs.coffee"
    config.output = "test/specs.js"
  end
end  

task :reload do
  listener = FSEvent.new
  listener.watch ['lib','test'] do
    tab = app("Google Chrome").windows[0].active_tab
    puts "#{Time.new.strftime("%I:%M:%S")}      Detected change, reloading #{tab.URL.get}..."
    tab.reload
  end
  puts "Watching for changes..."
  listener.run
end