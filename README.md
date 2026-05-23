# tree --stats patch

A patch for the `tree` utility (v2.1.1) that adds a `--stats` flag to display
detailed directory statistics after the tree listing.

## What it does

Running `tree --stats` appends a stats summary to the normal tree output:

--- Stats ---
Directories : 9
Files       : 55
Total size  : 794440 bytes

## Why

The existing `tree` output shows a basic summary line like:
`9 directories, 55 files`

This patch extends that with total size on disk, useful for quickly
auditing directory contents without running a separate `du` command.

## Files changed

- `tree.c` — added `statsflag` bool, `--stats` argument parsing, help text
- `list.c` — added stats output block after `lc.report(tot)`

## How to build

```bash
apt source tree
cd tree-2.1.1
patch -p1 < 0001-add-stats-flag.patch
make
./tree --stats
```

## Patch

See `0001-add-stats-flag.patch` for the full diff.
