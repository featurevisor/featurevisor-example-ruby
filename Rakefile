require 'rake'

# Default task
task default: [:run]

# Run the web server
desc "Run the Hello World web server"
task :run do
  puts "Starting Ruby Hello World Web Server..."
  puts
  system("ruby app.rb")
end

# Start server in background
desc "Start the web server in background"
task :start do
  puts "Starting Hello World web server in background..."
  puts "Server will be available at http://localhost:3000"
  puts "Use 'rake stop' to stop the server"
  system("ruby app.rb &")
  puts "Server started with PID: #{$?.pid}"
end

# Stop background server
desc "Stop the background web server"
task :stop do
  puts "Stopping background web server..."
  system("pkill -f 'ruby app.rb'")
  puts "Server stopped."
end

# Check if port is available
desc "Check if port 3000 is available"
task :check_port do
  require 'socket'
  begin
    server = TCPServer.new(3000)
    server.close
    puts "Port 3000 is available"
  rescue Errno::EADDRINUSE
    puts "Port 3000 is already in use"
    puts "You may need to stop another service or use a different port"
  end
end

# Clean temporary files
desc "Clean temporary files"
task :clean do
  puts "Cleaning temporary files..."
  FileList["*.log", "*.tmp", "*.temp"].each do |file|
    File.delete(file) if File.exist?(file)
  end
  puts "Cleanup complete!"
end

# Install dependencies
desc "Install gem dependencies"
task :install do
  puts "Installing gem dependencies..."
  system("bundle install")
end

# Run RuboCop
desc "Run RuboCop for code style checking"
task :lint do
  puts "Running RuboCop..."
  system("bundle exec rubocop")
end
