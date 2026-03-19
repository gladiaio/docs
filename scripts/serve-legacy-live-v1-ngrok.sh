#!/usr/bin/env bash

set -euo pipefail

DOMAIN="${NGROK_DOMAIN:-https://legacy-docs.ngrok.app}"
LEGACY_DIR="${LEGACY_DIR:-/Users/lazgladia/Documents/code/gladia-docs-live-v1-legacy}"
DOCS_PORT=3000
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROXY_SCRIPT="${SCRIPT_DIR}/tcp_proxy.rb"

if ! command -v ngrok >/dev/null 2>&1; then
  echo "ngrok is not installed or not on PATH." >&2
  exit 1
fi

if ! command -v ruby >/dev/null 2>&1; then
  echo "ruby is required for the local TCP proxy." >&2
  exit 1
fi

if [[ ! -d "${LEGACY_DIR}" ]]; then
  echo "Legacy worktree not found: ${LEGACY_DIR}" >&2
  exit 1
fi

random_free_port() {
  ruby -e '
    require "socket"
    loop do
      port = rand(20_000..59_999)
      begin
        server = TCPServer.new("127.0.0.1", port)
        server.close
        puts port
        exit 0
      rescue Errno::EADDRINUSE, Errno::EACCES
        next
      end
    end
  '
}

is_listening() {
  ruby -rsocket -e '
    host = "127.0.0.1"
    port = Integer(ARGV[0], 10)
    begin
      socket = TCPSocket.new(host, port)
      socket.close
      exit 0
    rescue StandardError
      exit 1
    end
  ' "$1"
}

cleanup() {
  if [[ -n "${PROXY_PID:-}" ]]; then
    kill "${PROXY_PID}" >/dev/null 2>&1 || true
  fi

  if [[ -n "${DOCS_PID:-}" ]]; then
    kill "${DOCS_PID}" >/dev/null 2>&1 || true
  fi
}

trap cleanup EXIT INT TERM

if is_listening "${DOCS_PORT}"; then
  echo "Using existing docs server on http://localhost:${DOCS_PORT}"
else
  echo "Starting legacy docs server from ${LEGACY_DIR}"
  (
    cd "${LEGACY_DIR}"
    npm run dev
  ) &
  DOCS_PID=$!

  for _ in {1..60}; do
    if is_listening "${DOCS_PORT}"; then
      break
    fi
    sleep 1
  done

  if ! is_listening "${DOCS_PORT}"; then
    echo "Legacy docs server did not start on port ${DOCS_PORT}." >&2
    exit 1
  fi
fi

FORWARD_PORT="$(random_free_port)"
echo "Selected random local port ${FORWARD_PORT}"

ruby "${PROXY_SCRIPT}" "${FORWARD_PORT}" "${DOCS_PORT}" &
PROXY_PID=$!

for _ in {1..10}; do
  if is_listening "${FORWARD_PORT}"; then
    break
  fi
  sleep 1
done

if ! is_listening "${FORWARD_PORT}"; then
  echo "Proxy did not start on port ${FORWARD_PORT}." >&2
  exit 1
fi

echo "Forwarding ${DOMAIN} to http://127.0.0.1:${FORWARD_PORT} -> http://127.0.0.1:${DOCS_PORT}"
exec ngrok http "${FORWARD_PORT}" --url "${DOMAIN}"
