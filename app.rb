#!/usr/bin/env ruby

# Simple Hello World Web Server
# This is a basic example to get you started with Ruby web development

require 'socket'
require 'featurevisor'
require 'net/http'
require 'json'

class HelloWorldServer
  def initialize(port = 3000)
    @port = port
    @server = nil

    ##
    # Initialize Featurevisor
    #
    datafile_url = "https://featurevisor-example-cloudflare.pages.dev/production/featurevisor-tag-all.json"

    # Fetch the datafile
    response = Net::HTTP.get(URI(datafile_url))
    datafile_content = JSON.parse(response)
    symbolized_datafile = symbolize_keys(datafile_content) # @TODO: this shouldn't be required

    # Create Featurevisor instance
    @featurevisor = Featurevisor.create_instance(
      datafile: symbolized_datafile,
    )
  end

  def symbolize_keys(obj)
    case obj
    when Hash
      obj.transform_keys(&:to_sym).transform_values { |v| symbolize_keys(v) }
    when Array
      obj.map { |v| symbolize_keys(v) }
    else
      obj
    end
  end

  def start
    puts "Starting Hello World Web Server on port #{@port}..."
    puts "Visit http://localhost:#{@port} in your browser"
    puts "Press Ctrl+C to stop the server"
    puts

    @server = TCPServer.new(@port)

    loop do
      begin
        client = @server.accept
        handle_request(client)
      rescue Interrupt
        puts "\nShutting down server..."
        break
      rescue => e
        puts "Error handling request: #{e.message}"
      ensure
        client&.close
      end
    end
  end

  def handle_request(client)
    request_line = client.gets
    return unless request_line

    method, path, version = request_line.split(' ')

    # Log the request
    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} - #{method} #{path}"

    # Read headers
    headers = {}
    while (line = client.gets) && line.strip != ''
      key, value = line.split(': ', 2)
      headers[key.downcase] = value&.strip
    end

    # Generate response
    response = generate_response(method, path)

    # Send response
    client.write(response)
  end

  def generate_response(method, path)
    if path == '/' && method == 'GET'
      # Get the feature flag value
      feature_flag_value = @featurevisor.is_enabled("my_feature")

      body = "Hello World. Feature flag value is: #{feature_flag_value}"
      status = '200 OK'
      content_type = "text/plain"
    else
      body = "Not Found"
      status = '404 Not Found'
      content_type = "text/plain"
    end

    response = [
      "HTTP/1.1 #{status}",
      "Content-Type: #{content_type}",
      "Content-Length: #{body.bytesize}",
      "Access-Control-Allow-Origin: *",
      "Connection: close",
      "",
      body
    ].join("\r\n")

    response
  end

  def stop
    @server&.close
    puts "Server stopped."
  end
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  server = HelloWorldServer.new(3000)

  begin
    server.start
  rescue Interrupt
    puts "\nReceived interrupt signal..."
  ensure
    server.stop
  end
end
