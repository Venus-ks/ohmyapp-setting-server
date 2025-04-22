#!/bin/bash

APP_PORT=9090

function kill_app() {
  if [ -n "$APP_PID" ]; then
    echo "🛑 Killing app process (PID: $APP_PID)"
    kill -9 $APP_PID
    wait $APP_PID 2>/dev/null
    APP_PID=""
  else
    PID=$(lsof -ti tcp:$APP_PORT)
    if [ -n "$PID" ]; then
      echo "🛑 Port $APP_PORT in use. Killing PID $PID"
      kill -9 $PID
      wait $PID 2>/dev/null
    fi
  fi
}


function run_app() {
  echo "🚀 Running bootRun..."
  gradle bootRun --no-daemon &
  APP_PID=$!
}

trap 'echo "🧹 Cleaning up..."; kill_app; exit' INT TERM

kill_app
gradle classes
run_app

while inotifywait -e modify -r src/main/java; do
  echo "🔁 변경 감지됨. 재빌드 & 재시작"
  kill_app
  gradle classes
  run_app
done
