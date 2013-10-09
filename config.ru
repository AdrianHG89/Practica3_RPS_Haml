require './lib/RockPaperScissors'

builder = Rack:: Builder.new do

run RockPaperScissors::RPS.new
end

Rack::Handler::Thin.run builder
