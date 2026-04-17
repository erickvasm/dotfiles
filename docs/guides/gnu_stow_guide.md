# GNU Stow Guide (Symbolic Links)

## What is GNU Stow?

GNU Stow is a symlink farm manager that helps you organize configuration
files (dotfiles) by creating symbolic links from a central directory to
target locations like your home directory.

------------------------------------------------------------------------

## Usage

### 1. Navigate to your stow directory

``` bash
cd dotfiles
```

### 2. Create symlinks

``` bash
stow bash
```

This will create:

    ~/.bashrc -> dotfiles/bash/.bashrc

------------------------------------------------------------------------

## Multiple Packages

``` bash
stow bash git
```

------------------------------------------------------------------------

## Delete (Unstow)

``` bash
stow -D bash
```

------------------------------------------------------------------------

## Restow (Recreate links)

``` bash
stow -R bash
```

------------------------------------------------------------------------

## Change Target Directory

``` bash
stow -t /custom/path bash
```

------------------------------------------------------------------------

## Best Practices

- Keep one app per folder (package)
- Mirror your home directory structure inside packages
- Use version control (e.g., Git)

------------------------------------------------------------------------

## Common Errors

- **File already exists**: Remove or backup the file before stowing
- **Conflicts**: Stow will refuse to overwrite existing files

------------------------------------------------------------------------

## Tips

- Use `--verbose` to see what Stow is doing:

``` bash
stow -v bash
```

- Dry run:

``` bash
stow -n bash
```

------------------------------------------------------------------------

## Conclusion

GNU Stow is a powerful and simple way to manage dotfiles using symbolic
links, keeping your setup clean and reproducible.
