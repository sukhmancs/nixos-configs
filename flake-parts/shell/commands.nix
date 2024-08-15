[
  {
    help = "Rebuild the system using nh os switch";
    name = "sw";
    command = "nh os switch";
    category = "build";
  }
  {
    help = "Rebuild the system using nh os boot";
    name = "bt";
    command = "nh os boot";
    category = "build";
  }
  {
    help = "Format source tree using treefmt";
    name = "fmt";
    command = "treefmt";
    category = "formatter";
  }
  {
    help = "Format nix files with Alejandra";
    name = "alejandra";
    package = "alejandra";
    category = "formatter";
  }
  {
    help = "Fetch source from origin";
    name = "pull";
    command = "git pull";
    category = "source control";
  }
  {
    help = "Format source tree and push commited changes to git";
    name = "push";
    command = "git push";
    category = "source control";
  }
  {
    help = "Update flake inputs and commit changes";
    name = "update";
    command = ''nix flake update && git commit flake.lock -m "flake: bump inputs"'';
    category = "utils";
  }
]
