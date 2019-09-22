#!/bin/bash/

FOLDER=$1

pandoc "$FOLDER/notes.txt" --pdf-engine=xelatex -o "$FOLDER/notes.pdf"
