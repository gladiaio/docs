#!/usr/bin/env ruby

require "socket"

if ARGV.length != 2
  warn "Usage: tcp_proxy.rb <listen_port> <target_port>"
  exit 1
end

listen_port = Integer(ARGV[0], 10)
target_port = Integer(ARGV[1], 10)

server = TCPServer.new("127.0.0.1", listen_port)

def pipe(source, destination)
  Thread.new do
    begin
      loop do
        data = source.readpartial(16 * 1024)
        destination.write(data)
      end
    rescue EOFError, IOError, Errno::EPIPE, Errno::ECONNRESET
      nil
    ensure
      begin
        destination.close
      rescue StandardError
        nil
      end
    end
  end
end

loop do
  client = server.accept

  Thread.new(client) do |incoming|
    outgoing = nil

    begin
      outgoing = TCPSocket.new("127.0.0.1", target_port)
      upstream = pipe(incoming, outgoing)
      downstream = pipe(outgoing, incoming)
      upstream.join
      downstream.join
    rescue StandardError => error
      warn "proxy error: #{error.message}"
    ensure
      begin
        incoming.close
      rescue StandardError
        nil
      end

      begin
        outgoing&.close
      rescue StandardError
        nil
      end
    end
  end
end
