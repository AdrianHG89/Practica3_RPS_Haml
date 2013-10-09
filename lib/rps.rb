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
					"Estas salvado, #{player_throw} contra #{computer_throw} es un empate."
				elsif computer_throw == @defeat[player_throw]
					"Muy bien, #{player_throw} gana a #{computer_throw}. ¿Te atreves a seguir jugando?"
				else
					"Oh has perdido, #{computer_throw} gana a #{player_throw}. Sigue intentandolo, ¡Suerte!"
				end
			engine = Haml::Engine.new File.open("views/rps.html.haml").read
			res = Rack::Response.new
			res.write engine.render({},
				:anwser => anwser,
				:choose => @choose,
				:throws => @throws,
				:computer_throw => computer_throw,
				:player_throw => player_throw)

			res.finish





		end # End del def call
	end #End de class
end #End del module
