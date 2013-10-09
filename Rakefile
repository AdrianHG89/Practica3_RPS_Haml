desc "run the server"
task :default do
  sh "ruby rps.rb"
end

desc "run the client with rock"
task :rock do
  sh %q{curl -v 'http://localhost:9292?choice=rock'}
end

desc "run the client with paper"
task :paper do
  sh %q{curl -v 'http://localhost:9292?choice=paper'}
end

desc "run the client with scissors"
task :scissors do
  sh %q{curl -v 'http://localhost:9292?choice=scissors'}
end
