
OUT=$(acpi | grep -o '[0-9]\{1,3\}%' | sed 's/%//')

printf $OUT
# printf "40"
