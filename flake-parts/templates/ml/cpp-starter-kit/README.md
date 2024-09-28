[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

# A Nix Basde C++ Project Template

This repo is used as a template for creating C++ projects.

1. It provides a Nix-based development environment (devShell).
   
   To activate the `devShell`, run `nix develop`.
2. It provides a working `CMakeLists.txt` that supports unit testing and installation.
3. It provides a `default.nix` as a starting point to package your awesome C++ projects for others to depend on.

# Details

You can find the details about how this template is created (and
therefore how to customize it to your needs) in this [blog
post](https://www.breakds.org/post/nix-based-c++-workflow/).
