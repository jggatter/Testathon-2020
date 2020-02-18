#!/bin/bash
wdl="${1##*/}"
cp ./inputs/${wdl%.wdl}.json . || exit 1
echo java -jar cromwell-*.jar run ${wdl} --inputs ${wdl%.wdl}.json
java -jar cromwell-*.jar run ${wdl} --inputs ${wdl%.wdl}.json
rm ${wdl%.wdl}.json