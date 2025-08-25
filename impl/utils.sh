# This is a utility script to be sourced by individual demos

COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_PURPLE="\033[35m"
COLOR_CYAN="\033[36m"

COLOR_CLEAR="\033[0m"

# outputs the given message in an instructional color
function say() {
  echo -e "${COLOR_CYAN}$*${COLOR_CLEAR}"
}

function displayCommand() {
  echo "$ $*"
}

function runCommand() {
  displayCommand "$*"
  bash -c "$*"
}

function downloadMapper() {
  # setup
  fileVersion="1.2.0-beta10"
  filename="x-mapper-$fileVersion.jar"
  url="https://github.com/mathjeff/Mapper/releases/download/$fileVersion/$filename"
  cacheDir="../../impl/cache"
  mkdir -p "$cacheDir"
  destFile="$cacheDir/$filename"
  downloadCommand="curl -L $url -o $destFile"
  # download Mapper to the cache
  if [ ! -e "$destFile" ]; then
    runCommand "$downloadCommand"
  else
    # We already downloaded Mapper but it might be more informative to re-display the download command again
    displayCommand "$downloadCommand"
  fi

  runCommand cp "$destFile" "mapper.jar"
}

function pause() {
  say "(Press Enter to continue)"
  read
}

function quiz() {
  # save answers
  rm -f /tmp/quiz-answers
  touch /tmp/quiz-answers
  rightAnswer=""
  while [ "$1" != "" ]; do
    answer="$1"
    if [ "$rightAnswer" == "" ]; then
      rightAnswer="$answer"
    fi
    echo "$answer" >> /tmp/quiz-answers
    shift
  done
  # order answers randomly
  cat /tmp/quiz-answers | shuf | grep -n . > /tmp/shuffled-answers
  cat /tmp/shuffled-answers
  # output answers
  rightAnswerLine="$(grep "$rightAnswer" /tmp/shuffled-answers)"
  while true; do
    read userInput
    userLine="$(grep "$userInput" /tmp/shuffled-answers || true)"
    if [ "$userLine" == "" ]; then
      say "That's not a choice - try again!"
      continue;
    fi
    if [ "$userLine" == "$rightAnswerLine" ]; then
      say "That's right!";
      echo
      return
    else
      say "You chose '$userLine'"
      say "That's not the answer we had in mind. Try again!"
    fi
  done
}
