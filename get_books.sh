#!/bin/bash

mkdir -p /scratch/$USER/books
aws s3 cp s3://public-xda8uy/ /scratch/$USER/books/ --recursive --exclude "*" --include "*.txt"
find /scratch/$USER/books -maxdepth 1 -type f -name "*.txt" | sort > book_list.txt

