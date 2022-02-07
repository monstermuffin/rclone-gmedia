#!/bin/bash

# Stop script if error
set -e

# Set vars
log='<rclone-log-dir>/upload.log'
script=$(basename $0)
date=$(date)

# Print date header to log
printf "\n\n############## $date ##############\n\n" >> $log

# If script already running, print to log and exit
if pidof -o %PPID -x "$script"
then

	printf 'Script already running. Exiting.' >> $log

# Else rclone move
else

	/usr/bin/rclone move \
		<local-mountpoint> gdrive-media-crypt: \
		--config /home/<youruser>/.config/rclone/rclone.conf \
		--log-file $log \
		--log-level INFO \
		--delete-empty-src-dirs \
		--fast-list \
		--min-age <min-age> \
		--progress

fi

# Print end footer to log
printf "\n############## Done ##############"
