#!/bin/bash

for i in *
do
    tesseract "$i" stdout -l ara --oem 1 >> outtext.txt
    { echo "$i" ;echo '------------------------------------------------------'; } >> outtext.txt
done
