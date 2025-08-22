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
