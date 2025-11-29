#!/bin/sh
# <https://apidog.com/blog/supabase-api/>
set -x

# Set ALL:
#	PS_DATABASE
#	PS_TABLE
#	PS_APIKEY

curl "https://$PS_DATABASE.supabase.co/rest/v1/$PS_TABLE" \
	-H "apikey: $API_KEY" \
	-H "Authorization: Bearer $PS_APIKEY" \
	-X POST \
	-H "Content-Type: application/json" \
	-d '{"id": 1, "msg": "fff"}'
