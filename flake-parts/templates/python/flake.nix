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
          [python311]
          ++ (with pkgs.python311Packages; [
            pip
            venvShellHook
            ipython
            black
            setuptools
            pylint
            #poetry
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
        '';
      };
    });
  };
}
