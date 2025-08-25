#!/bin/bash
set -e

cd "$(dirname $0)"

source ../../impl/utils.sh

echo "Welcome to the Mapper demo!"
echo
echo "Mapper is a tool that does sequence alignment"
pause
echo "A sequence alignment matches up similar nucleotides in two sequences."
echo "Here is a diagram of a sequence alignment:"
echo
echo ACACGTGG
echo ACACGTGG
echo
echo "This sequence alignment is pretty simple because the two sequences are the same!"
pause
echo "Here is a diagram of a slightly more complicated sequence alignment:"
echo
echo 'ACACGTGG'
echo '    !   '
echo 'ACACTTGG'
echo
echo "These two sequences have one difference between them, which we marked with a '!'"
echo "The G was replaced by a T"
pause
echo "Here is a diagram of a more complicated sequence alignment:"
echo
echo 'ACACTTTGG'
echo '    !   '
echo 'ACAC-TTGG'
echo
echo "There was an additional 'T' inserted into the first sequence, which we marked with a '!'"
pause
echo "Here is a diagram of an even more complicated sequence alignment:"
echo 'ACAC-TTGGCTC'
echo '    !   !   '
echo 'ACACTTTGCCTC'
echo "There was a a 'T' removed from the first sequence, and a G was also replaced by a C"
