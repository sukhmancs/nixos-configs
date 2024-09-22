_: {
  flake.templates = {
    python = {
      path = ./python; # Python
      description = "Python Development environment";
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
