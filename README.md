# Environment Setup for Build Performance training

Shirt store with large number of simple products assigned to each configurable.

# Variations

- Small (~5k SKU)
- Medium (~ 26k SKU)
- Large (~ 260k SKU)

# Git LFS

This repository uses Git LFS to store large database dumps, so you need to make sure to install LFS plugin:
https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage

After plugin is installed you need to do pull of files:
```
git lfs pull
```

# Installation

If you have warden installed and properly configured:

`make`

# Switching to another dataset

- `make small` will use small database
- `make medium` will use medium database
- `make large` will use large database
