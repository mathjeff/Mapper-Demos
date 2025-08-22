# This is a utility script to be sourced by individual demos

function runCommand() {
  echo "$ $*"
  bash -c "$*"
}

function downloadMapper() {
  runCommand "curl -L https://github.com/mathjeff/Mapper/releases/download/1.2.0-beta10/x-mapper-1.2.0-beta10.jar -o mapper.jar"
}

function pause() {
  echo "(Press Enter to continue)"
  read
}
