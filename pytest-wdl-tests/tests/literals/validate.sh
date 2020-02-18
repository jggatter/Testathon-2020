#!/bin/bash
wdl="${1##*/}"
java -jar womtool-* validate ${wdl}
