# Ruby Hello World Web Server

A simple Ruby web server that demonstrates basic HTTP server concepts with a Hello World response.

## Features

- Lightweight HTTP server built with pure Ruby
- Responds with "Hello World" on the root endpoint
- Request logging and error handling
- Graceful shutdown with Ctrl+C

## Prerequisites

- Ruby 2.7.0 or higher
- Bundler (for managing dependencies)

## Installation

1. **Clone or download this repository**
   ```bash
   git clone <repository-url>
   cd featurevisor-example-ruby
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```
   
   Or use the rake task:
   ```bash
   rake install
   ```

## Running the Web Server

### Method 1: Using Rake (recommended)
```bash
rake run
```

### Method 2: Direct Ruby execution
```bash
ruby app.rb
```

### Method 3: Start in background
```bash
rake start
```

### Method 4: Make the file executable and run
```bash
chmod +x app.rb
./app.rb
```

## Accessing the Server

Once the server is running, you can access it at:

- **Main endpoint**: http://localhost:3000

## API Endpoints

### GET /
Returns a simple "Hello World" text response.

**Response:**
```
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: 11

Hello World
```

## Stopping the Server

- **If running in foreground**: Press `Ctrl+C`
- **If running in background**: Use `rake stop`

## Available Rake Tasks

- `rake run` - Start the web server in foreground
- `rake start` - Start the web server in background
- `rake stop` - Stop the background web server
- `rake check_port` - Check if port 3000 is available
- `rake install` - Install gem dependencies
- `rake lint` - Run RuboCop for code style checking
- `rake clean` - Clean temporary files

## Project Structure

```
featurevisor-example-ruby/
├── app.rb              # Main web server application
├── Gemfile             # Ruby dependencies
├── Rakefile            # Build tasks
├── .gitignore          # Git ignore patterns
├── .editorconfig       # Editor configuration
├── .ruby-version       # Ruby version specification
├── .rubocop.yml        # RuboCop configuration
└── README.md           # This file
```

## Development

### Code Style
This project uses RuboCop for code style enforcement. Run it with:
```bash
bundle exec rubocop
```

### Port Configuration
The server runs on port 3000 by default. You can change this by modifying the port number in `app.rb` or by creating a new instance with a different port.

## Troubleshooting

### Port already in use
If you get an "Address already in use" error, check if port 3000 is available:
```bash
rake check_port
```

### Ruby not found
If you get a "ruby: command not found" error, make sure Ruby is installed and in your PATH.

### Bundler not found
Install Bundler with:
```bash
gem install bundler
```

### Permission denied
If you get a permission error when running `./app.rb`, make sure the file is executable:
```bash
chmod +x app.rb
```

## Example Usage

### Starting the server:
```bash
$ rake run
Starting Ruby Hello World Web Server...
Starting Hello World Web Server on port 3000...
Visit http://localhost:3000 in your browser
Press Ctrl+C to stop the server

2024-01-15 10:30:00 - GET /
2024-01-15 10:30:05 - GET /
```

### Testing with curl:
```bash
# Test main endpoint
curl http://localhost:3000/
# Output: Hello World
```

## Contributing

Feel free to modify this basic template to suit your needs. This is a starting point for learning Ruby web development or building more complex web applications.

## License

This project is open source and available under the [MIT License](LICENSE).
