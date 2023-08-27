#!/bin/bash

FILES=$(ls -p | grep -vP ".*\.sh|/")

for FILE in $FILES 
do

	YEAR=$(date -r "$FILE" "+%Y")
	YEAR_DIR="memories-${YEAR}"

	if [ ! -d "$YEAR_DIR" ]; then
		mkdir "$YEAR_DIR" 
	fi
	mv "$FILE" "${YEAR_DIR}/"

done

YEAR_SUBDIRS=$(find ./ -maxdepth 1 -mindepth 1 -type d)
MONTH_ARRAY=("Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
for YEAR_SUBDIR in $YEAR_SUBDIRS
do
	NUM_SUBDIRS=0
	cd "$YEAR_SUBDIR"
	# check if there are subdirs, otherwise add 12 subdirs
	NUM_SUBDIRS=$(find ./ -maxdepth 1 -mindepth 1 -type d | wc -l)
	if [ "$NUM_SUBDIRS" -eq 0 ]; then
		for MONTH in "${MONTH_ARRAY[@]}"
		do
			mkdir "$MONTH"
		done
	fi
	FILES=$(ls -p | grep -vP ".*sh|/")
	# sort photos into their respective subfolders
	for FILE in $FILES 
	do
		MONTH=$(date -r "$FILE" "+%b")
		mv "$FILE" "${MONTH}/"

	done
	cd ..
done
