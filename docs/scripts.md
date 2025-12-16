# Scripts

## Note on Environment Variables

All scripts that interface with the database require some environment variables
defined to access the database.

For the some of the scripts you will need the name of the *supabase* (the
subdomain of your database), the specific table in your database, and a
api-key. You can use a simple script like the following to make this process
easier:

```bash
export PS_DATABASE="..."
export PS_TABLE="..."
export PS_APIKEY="..."

# Execute First Argument as script
# and Pass rest to script
$1 "${@:2}"
```

What and how to use the script is defined in the file.

## Examples

`./readmail.sh`:

[![asciicast](./casts/scripts/readmail.gif)](/docs/casts/scripts/readmail.gif)
