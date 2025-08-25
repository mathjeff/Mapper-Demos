#!/bin/bash
set -e

cd "$(dirname $0)"

source ../../impl/utils.sh

echo "Let's download Mapper"
pause
downloadMapper
echo "Now let's run Mapper"
pause
runCommand "java -jar mapper.jar --queries query.fasta --reference reference.fasta --out-sam out.sam -v"
echo
echo "That is a lot of output, isn't it?"
echo "Take a look at the part in the middle that says 'Query:' and 'Aligned ref  :'"
