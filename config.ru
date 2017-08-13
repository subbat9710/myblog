require './app.rb'
use Rack::Static, :urls => ['/css'], :root => 'public'