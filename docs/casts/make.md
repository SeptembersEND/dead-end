# Creating a cast

- [ASCIICAST Quick Start Guide](https://docs.asciinema.org/manual/cli/quick-start/)


## Filename

The filname should be create with the name of the executable followed by what
action is taking place. Have the file extension be `.cast`. Then put the cast
into the file corrisponding to the type of the executable.

For Example: `script/readmail.cast` for a script utility cast called readmail.

When you create a gif using [agg](https://github.com/asciinema/agg) save it to
the same filename and path replacing the `.cast` with a `.gif`.


## Shapping

- [ASCIICAST v2 Documentation](https://docs.asciinema.org/manual/asciicast/v2/)
- [ASCIICAST v3 Documentation](https://docs.asciinema.org/manual/asciicast/v3/)

Please include the following headers with the recommended values:

- version: 3
- term
    - cols: 80
    - rows: 24
- title: PROGRAM-EXECUTABLE TYPE ACTION
