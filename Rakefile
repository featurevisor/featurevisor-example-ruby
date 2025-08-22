require 'rake'

# Default task
task default: [:run]

# Run the Hello World program
desc "Run the Hello World program with Featurevisor"
task :run do
  puts "Running Ruby Hello World program with Featurevisor..."
  puts
  system("ruby app.rb")
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
