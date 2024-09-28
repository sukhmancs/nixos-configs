_: {
  flake.templates = {
    python = {
      path = ./python; # Python
      description = "Python Development environment";
    };

    torch-basics = {
      path = ./ml/torch-basics;
      description = "A template for a basic machine learning project with PyTorch";
    };

    cpp-starter-kit = {
      path = ./ml/cpp-starter-kit;
      description = "A template for a c++ development project skeleton with CMake";
    };

    js-webapp-basics = {
      path = ./ml/js-webapp-basics;
      description = "A template for creating javascript/typescript web application development environment";
    };

    langchain-basics = {
      path = ./ml/langchain-basics;
      description = "A template for creating a langchain based LLM application";
    };

    pybind11-starter-kit = {
      path = ./ml/pybind11-starter-kit;
      description = "A template that creates a skeleton for a pybind11 module, including development environment and nix packaging";
    };

    maturin-basics = {
      path = ./ml/maturin-basics;
      description = "A template as the starting point for building a pyo3 (rust) based python package.";
    };

    c = {
      path = ./c; # C/C++
      description = "Development environment for C/C++";
    };

    rust = {
      path = ./rust; # Rust
      description = "Development environment for Rust";
    };

    node = {
      path = ./node; # NodeJS
      description = "Development environment for NodeJS";
    };

    go = {
      path = ./go; # golang
      description = "Development environment for Golang";
    };

    java = {
      path = ./java; # Java
      description = "Development environment for Java";
    };

    php = {
      path = ./php; # PHP
      description = "Development environment for PHP";
    };
  };
}
