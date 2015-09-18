# freezer_burn
Rough management of compressed log files.

## Code Status

[![Build Status](https://travis-ci.org/shadowbq/freezer_burn.svg?branch=master)](https://travis-ci.org/shadowbq/freezer_burn)
[![Code Climate](https://codeclimate.com/github/shadowbq/freezer_burn/badges/gpa.svg)](https://codeclimate.com/github/shadowbq/freezer_burn)
[![Test Coverage](https://codeclimate.com/github/shadowbq/freezer_burn/badges/coverage.svg)](https://codeclimate.com/github/shadowbq/freezer_burn)
[![GitHub tag](https://img.shields.io/github/tag/shadowbq/freezer_burn.svg)](http://github.com/shadowbq/freezer_burn)

## Usage
```shell
$> freezer_burn -h
Rough management for compressing and managing log files.

Usage:
  ./bin/freezer_burn passivedns [-vdk] [--version] [-f <fridge>] [-F <freezer>]
  ./bin/freezer_burn cxtracker [-vdk] [--version] [-f <fridge>] [-F <freezer>]
  ./bin/freezer_burn -h | --help

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
$> freezer_burn -dvk -F /man
Searching 1436932800 -> 1437019200: 0 files

$> freezer_burn passivedns -dv -F /man --version
version => 0.0.4
verbose => true
dryrun => true
fridge => /var/db/yard/pdns.*
freezer => /man
gnu_tar_command => gtar
remove_files => --remove-files
prefix => passivedns
max_scan_time_in_sec => 31536000
```
