#
# Python development environment
#
# It will install some python packages that are packaged with nixpkgs. But you can also install packages using pip.
#
{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        venvDir = ".venv";
        packages = with pkgs;
          [
            python3
            # (pkgs.python3.withPackages (ps: [
            #   ps.pip
            #   ps.tkinter
            # ]))
          ]
          # These packages that are packaged with nixpkgs. You can also install packages using pip.
          # For some reason, if I include pip in this list of packages, the packages installed with pip are not available in the shell environment.
          # Instead u get an Error: No module named 'your_module'. It works fine if using pkgs.python3.withPackages (i.e the latest python version).
          # For me, I usually need to deal with older python versions, most of the time tenorflow, pytorch, relies on some older packages like distutils
          # which are removed from python 3.12+.
          ++ (with pkgs.python3Packages; [
            pip
            venvShellHook
            ipython
            ipykernel # required for jupyter notebooks
            black
            setuptools
            pylint
            #poetry # I dont like poetry
          ]);
        shellHook = ''
          # Define shell aliases
          alias py='python'
          alias py2='python2'
          alias py3='python3'
          alias po='poetry'
          alias ipy='ipython --no-banner'
          alias ipylab='ipython --pylab=qt5 --no-banner'

          # Set environment variables
          export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
          export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
          export PYTHONUSERBASE="$XDG_DATA_HOME/python"
          export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
          export PYTHONHISTFILE="$XDG_DATA_HOME/python/python_history"
          export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
          export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
          export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
          export PIP_LOG_FILE="$XDG_STATE_HOME/pip/log"
          export PYLINTHOME="$XDG_DATA_HOME/pylint"
          export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
          export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

          # Tells pip to put packages into $PIP_PREFIX instead of the usual locations.
          # See https://pip.pypa.io/en/stable/user_guide/#environment-variables.
          export PIP_PREFIX=$(pwd)/_build/pip_packages
          export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
          export PATH="$PIP_PREFIX/bin:$PATH"
          unset SOURCE_DATE_EPOCH
        '';
      };
    });
  };
}
