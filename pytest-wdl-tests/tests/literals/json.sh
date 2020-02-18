#!/bin/bash
wdl="${1##*/}"
java -jar womtool-* inputs ${wdl} > ${wdl%.wdl}.json
mkdir -p ./inputs
mv ${wdl%.wdl}.json ./inputs