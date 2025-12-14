#!/bin/sh
# <https://apidog.com/blog/supabase-api/>
if [[ -z "$PS_DATABASE" || -z "$PS_TABLE" || -z "$PS_APIKEY" ]]; then
	echo -e 'Usage: PS_DATABASE="<database>" PS_TABLE="<table>" PS_APIKEY="<key>"'
	echo -e 	'\tget-all.sh'
	echo -e '\e[31mNo environment variables specified\e[0m'
	exit
fi

curl "https://$PS_DATABASE.supabase.co/rest/v1/$PS_TABLE" \
	-H "apikey: $PS_APIKEY" \
	-H "Authorization: Bearer $PS_APIKEY" \
	-X GET
