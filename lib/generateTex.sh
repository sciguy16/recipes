#!/bin/bash

echo "ENTERING generateTex.sh" >&2

# Arguments are title file, description file, ingredients file, method file,
# and template file

TITLE="$1"
DESCRIPTION="$2"
INGREDIENTS="$3"
METHOD="$4"
TEMPLATE="$5"

(
	# read in template file
	echo "r $TEMPLATE"

	# search for title marker in buffer, then delete the title
	# marker and read in the title file to the current position
	echo "/::TITLE::"
	echo "d"
	echo "-r $TITLE"

	# search for description marker in buffer, then delete the description
	# marker and read in the description file to the current position
	echo "/::DESCRIPTION::"
	echo "d"
	echo "-r $DESCRIPTION"

	# search for where the ingredients marker is and start writing
	echo "/::INGREDIENTS::"
	echo "d"
	echo "-a"
	while read -r LINE ; do
		echo "\item $LINE"
	done < $INGREDIENTS
	# we have finished writing the ingredients
	echo "."


	# search for where the method marker is and start writing
	echo "/::METHOD::"
	echo "d"
	echo "-a"

	while read -r LINE ; do
		echo "\item $LINE"
	done < $METHOD

	# we have finished writing the method
	echo "."

	# save and quit
	echo "w tmprecipe.tex"
	echo "q"
) | ed
