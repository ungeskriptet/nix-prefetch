#!/usr/bin/env bash
help () {
  cat <<EOF
Options:
-a | --attr <attribute name>
-p | --path <path> (Default: "./." when --attr is used)
-d | --dep <fetcher attribute name> (Default: "src")

When --attr is unset, callPackage method will be used to get the hash for the package specified in --path.
Otherwise, --path will be imported and fetchers from the imported path will be used.
EOF
}

# Defaults
dep="src"

while [ $# -gt 0 ]; do
  case "$1" in
    --path|-p) path="$2"; shift 2 ;;
    --attr|-a) attr="$2"; shift 2 ;;
    --dep|-d) dep="$2"; shift 2 ;;
    --help|-h) help; exit ;;
    *) break ;;
  esac
done

if [ -z "$attr" ] && [ -n "$path" ]; then
  echo "Using callPackage method to get hash"
  nix-build call-package.nix \
    --argstr path $(realpath $path) \
    --argstr dep $dep
elif [ -n "$attr" ]; then
  [ -z "$path" ] && path="./.";
  echo "Using fetchers from $path"
  nix-build custom.nix \
    --argstr attr $attr \
    --argstr path $(realpath $path) \
    --argstr dep $dep
else
  help
  exit 1
fi
