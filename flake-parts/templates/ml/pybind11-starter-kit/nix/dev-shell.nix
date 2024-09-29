{ mkShell
, stdenv
, clang-tools
, python3
, cmake
, cmakeCurses
, gtest
, spdlog
}:

let pythonEnv = python3.withPackages (pyPkgs: with pyPkgs; [
      numpy
      pybind11
    ]);

    mkClangShell = mkShell.override {
      # Using clang 16 for being a little bit cutting edge. Just use the normal
      # stdenv if you do not need this.
      stdenv = stdenv;
    };

in mkClangShell rec {
  name = "my-pybind11-proj";

  packages = [
    # C++ Toolchain
    cmake
    cmakeCurses

    # Python environment
    pythonEnv

    # Development Tools
    clang-tools

    # Other dependencies
    spdlog
    gtest
  ];

  shellHook = ''
     export PS1="$(echo -e '\uf1c0') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
  '';
}
