#!/bin/bash
# readmail.sh - utility to read decrypted mail
#
# This utility is a simple mail reader used to go through your mail without
# execute a command per mail entry.
#
# This utility allows you to browse through your decrypted mail and copy what
# you want to your clipboard, using the xclip utility.
#
# context: assumes that you have your mail stored in `/tmp/mail/`
# context: needs environment variables like get-all.sh does.

MAILDIR=/tmp/mail


end() {
	echo -e "\e[2K\e8"
	exit $1
}

# TODO: Specify start
echo -e "\e7" # Move up 1 and Save cursor position
for file in ${MAILDIR}/msgs/*; do
	COPIED=0
	while true; do
		if [[ "$KEY" != "c" && "$KEY" != "C" ]]; then
			echo -e "\e[36mFrom: \e[35m$file\e[0m\n\n" |
				cat - $file | less -R
		fi
		# Clear current line and restore saved cursor position
		echo -e "\e[2K\e8"
		read -n 1 -r -p "$(basename $file) - (q)uit, (other) next: " KEY

		case $KEY in
		q|Q)
			end
			;;
		c|C)
			cat $file | xclip -selection clipboard
			if [[ "$COPIED" -eq 0 ]]; then
				echo -e "\e8\e[2KCopied to Clipboard"
			else
				echo -e "\e8\e[2K(x$COPIED) Copied to Clipboard"
			fi
			COPIED=$((COPIED+1))
			;;
		*)
			break
			;;
		esac

	done
done

end
