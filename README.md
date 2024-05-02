nix run nixkpkgs#\<PKG> -- \<ARGS>

Neovim's mason will not install python packages which are already cached in .pip-global. If mason throws "Package is not executable in virtual environment", delete .pip-global.
