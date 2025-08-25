#!/bin/bash
set -e

cd "$(dirname $0)"

source ../../impl/utils.sh

say "Let's download Mapper"
pause
downloadMapper
say "Now let's run Mapper"
pause
runCommand "java -jar mapper.jar --queries query.fasta --reference reference.fasta --out-sam out.sam -v"
say
say "That is a lot of output, isn't it?"
say "Take a look at the part in the middle that says 'Query:' and 'Aligned ref  :'"
