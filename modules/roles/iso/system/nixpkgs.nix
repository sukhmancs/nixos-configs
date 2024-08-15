{
  nixpkgs = {
    # Configuration reference:
    # <https://nixos.org/manual/nixpkgs/unstable/#chap-packageconfig>
    config = {
      # Allow broken packages to be built. Setting this to false means packages
      # will refuse to evaluate sometimes, but only if they have been marked as
      # broken for a specific reason. At that point we can either try to solve
      # the breakage, or get rid of the package entirely.
      allowBroken = false;
      allowUnsupportedSystem = true;

      # Really a pain in the ass to deal with when disabled. True means
      # we are able to build unfree packages without explicitly allowing
      # each unfree package.
      allowUnfree = true;
    };
  };
}
