#!/bin/sh
# <https://apidog.com/blog/supabase-api/>
set -x

# Set ALL:
#	PS_DATABASE
#	PS_TABLE
#	PS_APIKEY

echo $PS_DATABASE
echo $PS_TABLE
echo $PS_APIKEY

curl "https://$PS_DATABASE.supabase.co/rest/v1/$PS_TABLE" \
	-H "apikey: $PS_APIKEY" \
	-H "Authorization: Bearer $PS_APIKEY" \
	-X GET
