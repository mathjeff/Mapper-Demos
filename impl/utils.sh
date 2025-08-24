# This is a utility script to be sourced by individual demos

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
    bash -c "$downloadCommand"
  else
    # We already downloaded Mapper but it might be more informative to re-display the download command again
    displayCommand "$downloadCommand"
  fi

  runCommand cp "$destFile" "mapper.jar"
}

function pause() {
  echo "(Press Enter to continue)"
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
      echo "That's not a choice - try again!"
      continue;
    fi
    if [ "$userLine" == "$rightAnswerLine" ]; then
      echo "That's right!";
      return
    else
      echo "You chose '$userLine'"
      echo "That's not the answer we had in mind. Try again!"
    fi
  done
}
