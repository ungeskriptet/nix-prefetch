# nix-prefetch
Small utility to get the hash for a nix package

Run nix-prefetch:
```
nix run https://codeberg.org/ungeskriptet/nix-prefetch/archive/master.tar.gz
```

Options:
```
-a | --attr <attribute name>
-p | --path <path> (Default: "./." when --attr is used)
-f | --file <path> (Alias for --path)
-d | --dep <fetcher attribute name> (Default: "src")

When --attr is unset, callPackage method will be used to get the hash for the package specified in --path.
Otherwise, --path will be imported and fetchers from the imported path will be used.
```
