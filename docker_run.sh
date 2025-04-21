while inotifywait -e modify -r src/main/java; do
  echo "🔁🔁🔁🔁🔁 Detected change, recompiling...🔁🔁🔁🔁🔁"
  gradle classes
done &

gradle bootRun