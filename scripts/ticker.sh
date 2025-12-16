#!/bin/sh
# get-all.sh - retreive all messages from database
#
# Queries database REST API to retreive all messages stored there.
#
# It uses three environment variables, 1) PS_DATABASE, the subdomain of the
# database, 2) PS_TABLE, the name of the table in your database, and 3)
# PS_APIKEY, the api-key used to query the server.
#
# context: needs environment variables defined to access database.

# source:
#	<https://apidog.com/blog/supabase-api/>

set -x
curl "https://$PS_DATABASE.supabase.co/rest/v1/$PS_TABLE?id=eq.-1" \
	-H "apikey: $PS_APIKEY" \
	-H "Authorization: Bearer $PS_APIKEY" \
	-X PATCH \
	-H "Content-Type: application/json" \
	-d '{"id": -1, "msg": "update ticker"}'
