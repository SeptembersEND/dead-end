#!/bin/bash
# mailbox.sh - Get mail from database
#
# In four stages, this simple bash script 1) retreives the mail from the server,
# 2) checks if any mail has changed, 3) Creates a temperary keyring, and 4)
# decrypts you mail and saves them to a file in a seperate directory.
#
# context: requires one argument, the private key used to decrypt.
# context: needs environment variables like get-all.sh does.
#
# return: 0 when successful execution, 1 on failure.

UMAIL=retreived
UMAILOLD=$UMAIL.old
KEYRING=keyring

# PRE CHECKS
if [ $# -ne 1 ]; then
	echo -e '\e[31mInvalid input\e[0m'
	echo -e 'Usage: PS_DATABASE="<database>" PS_TABLE="<table>" PS_APIKEY="<key>"'
	echo -e 	'\tmailbox.sh PRIVATE_KEY'
	exit
fi
if [ ! -f $1 ]; then
	echo -e '\e[31mPrivate "$1" key does not exist\e[0m'
	echo -e 'Usage: PS_DATABASE="<database>" PS_TABLE="<table>" PS_APIKEY="<key>"'
	echo -e 	'\tmailbox.sh PRIVATE_KEY'
	exit
fi
if [[ -z "$PS_DATABASE" || -z "$PS_TABLE" || -z "$PS_APIKEY" ]]; then
	echo -e '\e[31mNo environment variables specified\e[0m'
	echo -e 'Usage: PS_DATABASE="<database>" PS_TABLE="<table>" PS_APIKEY="<key>"'
	echo -e 	'\tmailbox.sh PRIVATE_KEY'
	exit
fi

# GET MAIL
if [ -f $UMAIL ]; then
	rm $UMAILOLD
	mv $UMAIL $UMAILOLD
fi
curl "https://$PS_DATABASE.supabase.co/rest/v1/$PS_TABLE" \
	-H "apikey: $PS_APIKEY" \
	-H "Authorization: Bearer $PS_APIKEY" \
	-X GET --output $UMAIL
if [ $? -ne 0 ]; then
	echo -e "\e[31mFailed to retreive data from server.\e[0m"
fi
# TODO: check if failed



# CHECK
if cmp $UMAIL $UMAILOLD; then
	echo "No update found"
	exit 0;
else
	echo "Update found"
fi



# KEYRING
export GPG_TTY=$(tty)
gpg -q --no-default-keyring --keyring $KEYRING --import $1



# DECRYPT
if [ -d msgs ]; then
	echo "Removing: $(ls -m msgs/*)"
fi
rm -Ir msgs

if ! mkdir -p msgs; then
	echo -e "\e[31mFailed to make 'msgs' directory\e[0m"
	exit 1
fi
COUNT=0
echo "Exported Mail to 'msgs_':"
cat $UMAIL | jq '.[]|.msg' |
	while read -r msg; do # `-r` does something to allow \n
		COUNT=$((COUNT+1))
		echo -e $msg | tr -d '"' |
			gpg -q --no-default-keyring --keyring $KEYRING -o msgs/msg_${COUNT} --decrypt
		echo -n "$COUNT "
	done
echo -e "\n"



# CLEANUP
rm -r $KEYRING
exit 0
