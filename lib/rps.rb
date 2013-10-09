require 'rack/request'
require 'rack/response'
require 'haml'
require 'thin'
require 'rack'
  
module RockPaperScissors
	class RPS 
 		def initialize(app = nil)
			@app = app
			@content_type = :html
			@defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
			@throws = @defeat.keys
			@choose = @throws.map { |x| 
				%Q{ <li><a href="/?choice=#{x}">#{x}</a></li> }
			}.join("\n")
       			@choose = "<p>\n<ul>\n#{@choose}\n</ul>"
		end #Ende del def initialize
  
		def call(env)
			req = Rack::Request.new(env)
 			req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
			computer_throw = @throws.sample
			player_throw = req.GET["choice"]
			anwser =
				if !@throws.include?(player_throw)
					"Choose one of the following:"
				elsif player_throw == computer_throw
					"You tied with the computer"
				elsif computer_throw == @defeat[player_throw]
					"Nicely done; #{player_throw} beats #{computer_throw}"
				else
					"Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
				end
			engine = Haml::Engine.new File.open("views/index.html.haml").read
			res = Rack::Response.new
			res.finish
		end # End del def call
	end #End de class
end #End del module
  
if $0 == __FILE__
    require 'rack'
    require 'rack/showexceptions'
    Rack::Server.start(
      :app => Rack::ShowExceptions.new(
               Rack::Lint.new(
                  RockPaperScissors::App.new)), 
      :Port => 9292,
      :server => 'thin'
    )
end
