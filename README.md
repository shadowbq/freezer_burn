# freezer_burn
Rough management of compressed log files

## Usage 
```shell
Example of program with many options using docopt.
Usage:
  ./bin/freezer_selector [-vdk] [--version] [-f <fridge>] [-F <freezer>]
  ./bin/freezer_selector -h | --help

Options:
  -f <fridge>          look for logs here
  -F <freezer>         store file here
  -k --keep-files      keep original files in the fridge
  -h --help            show this help message and exit
  --version            show version and exit
  -d --dry-run         simulate without moving files
  -v --verbose         print status messages
```

## Example Usage

```shell
[shadowbq@...](~/sandbox/freezer_burn)$ ./bin/freezer_selector -dvk -F /man
Searching 1436932800 -> 1437019200: 0 files

[shadowbq@...](~/sandbox/freezer_burn)$ ./bin/freezer_selector -dvk -F /man --version
version => 0.0.2
verbose => true
dryrun => true
fridge => /var/db/yard/stats.*
freezer => /man
gnu_tar_command => gtar
remove_files => 
prefix => cxtracker
max_scan_time_in_sec => 31536000
```
