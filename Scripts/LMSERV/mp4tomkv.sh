#!/bin/bash

# Usage: bash script.sh path/to/directory
IFS=$'\n'
count=0
for file in $(find "$1" -name "*.mp4"); do
    filename=$(basename "$file")
    dir=$(dirname "$file")
    echo ${dir}
    extension="${filename##*.}"
    filename="${filename%.*}"
    
    # Use ffmpeg to convert the file from .mp4 to .mkv
    ffmpeg -i "$file" -c copy "${dir}/${filename}.mkv"
    #echo "$file" >> converted_files.txt
    # Preserve the owner, group, and permissions of the original file
    chmod --reference="$file" "${dir}/${filename}.mkv"
    chown --reference="$file" "${dir}/${filename}.mkv"
    echo "$(cd "$dir" && pwd)/$filename.mp4" >> converted_files.txt
    count=$((count+1))
done

echo "${count} files were converted."
echo "The following files were converted:"
cat converted_files.txt

