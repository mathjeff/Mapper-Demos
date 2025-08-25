#!/bin/bash
set -e

cd "$(dirname $0)"

source ../../impl/utils.sh

say "We have an unknown sample that we want to compare to an unknown reference."
say "Let's download and run Mapper"
pause
downloadMapper
say "Now let's run Mapper"
runCommand "java -jar mapper.jar --queries queries.fasta --reference reference.fasta --out-sam out.sam --num-threads 8"
echo
say "Now look at the Alignment rate above."
pause
say "For most reads, we didn't find an alignment to the reference"
pause
say "Now take a look at the Alignment Penalties Graph above. What does it say?"
echo
answer1="We observe larger differences between the query and the reference more often"
answer2="We observe smaller differences between the query and the reference more often"
answer3="We observe longer queries to be more similar to the reference than shorter queries"
answer4="We observe shorter queries to be more similar to the reference than longer queries"
quiz "$answer1" "$answer2" "$answer3" "$answer4"

say "What should we expect in this graph?"
answer1="DNA mutates randomly so the distribution should follow a normal curve"
answer2="DNA mutates randomly so the distribution should be uniform"
answer3="DNA undergoes selection so each query should have the same number of mutations"
answer4="DNA undergoes selection so each query should have a different number of mutations"
quiz "$answer1" "$answer2" "$answer3" "$answer4"

say "It looks like the right side of our graph might be missing"
say "This might be because Mapper skips queries that are <90% similar to the reference by default"
echo
say "Let's run Mapper again, and ask it to also output alignments having >= 80% similarity"
pause
runCommand "java -jar mapper.jar --queries queries.fasta --reference reference.fasta --out-sam out.sam --num-threads 8 --max-penalty 0.2"
echo
say "Now check the Alignment rate again."
say "We found an alignment for every query!"
pause
say "You might wonder why Mapper doesn't always look for the best alignment for every query by default"
say "There are two reasons"
say "1. Aligning queries that are very different from the reference takes a while"
say "2. Queries that are very different from the reference might come from different species and might distract from what you're interested in. You can also lower the --max-penalty to output even fewer alignments"
