#!/bin/bash

source_file='lip@192.168.0.102:~/work/'"$@"
scp -r $source_file ./
