#!/bin/bash
set -e

cd "$(dirname $0)"

source ../../impl/utils.sh

echo "We have an unknown sample that we want to compare to an unknown reference."
echo "Let's download and run Mapper"
pause
downloadMapper
echo "Now let's run Mapper"
runCommand "java -jar mapper.jar --queries queries.fasta --reference reference.fasta --out-sam out.sam --num-threads 8"
echo
echo "Now take a look at the Alignment Penalties Graph above. What does it say?"
echo
answer1="We observe larger differences between the query and the reference more often"
answer2="We observe smaller differences between the query and the reference more often"
answer3="We observe longer queries to be more similar to the reference than shorter queries"
answer4="We observe shorter queries to be more similar to the reference than longer queries"
quiz "$answer1" "$answer2" "$answer3" "$answer4"
