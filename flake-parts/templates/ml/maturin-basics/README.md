# Maturin Basics Flake Template

## How to Use?

1. Init your project with this template
   
   ```console
   $ nix flake init --template "github:nixvital/flake-templates#maturin-basics"
   ```


2. Get into the devshell by 

   ```console
   $ nix develop .
   ```
   
3. Now, use `maturin` to initialize your project, and choose `pyo3`.

   ```console
   $ maturin init
   ```
   
4. Write code!
   
## How to test the resulting python package

If you are using `virtualenv` or `conda`, `maturin develop` is probably the way to go. However, it does not work for this nix-based development environment (let me know if you have a better idea to get `maturin develop` working!)

For now, I provided the packaging of the resulting python package [in the template](./nix/pkgs/self/default.nix).

You will need to adapt it to your project by

1. Update the name and version of package 
2. The hash for the `cargoDeps` will also need to be updated
   - **Note**: I usually just build it once and let it complain and show the true hash
3. Add your dependencies.

To test the package in a devshell, run `nix develop .#test`.
