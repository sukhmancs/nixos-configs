# Original Code by NotAShelf - https://github.com/notashelf/nyx
{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  extendedLib = lib.extend (self: super: let
    inherit (self.trivial) functionArgs;
    inherit (self.attrsets) filterAttrs mapAttrs recursiveUpdate;

    # credits go to @nrabulinski
    callLibs = path: let
      func = import path;
      args = functionArgs func;
      requiredArgs = filterAttrs (_: val: !val) args;
      defaultArgs = recursiveUpdate (mapAttrs (_: _: null) requiredArgs) {
        inherit inputs;
        lib = self;
      };
      functor = {__functor = _: attrs: func (recursiveUpdate defaultArgs attrs);};
    in
      (func defaultArgs) // functor;
  in {
    extendedLib = {
      aliases = callLibs ./aliases.nix;
      dag = callLibs ./dag.nix;
      firewall = callLibs ./firewall.nix {inherit (self.extendedLib) dag;};
      fs = callLibs ./fs.nix;
      modules = callLibs ./modules.nix;
      secrets = callLibs ./secrets.nix;
      systemd = callLibs ./systemd.nix;
      themes = callLibs ./themes.nix;
    };
    xdgTemplate = ./xdg.nix;

    inherit (self.extendedLib.aliases) sslTemplate common;
    inherit (self.extendedLib.dag) entryBefore entryBetween entryAfter entryAnywhere topoSort dagOf;
    inherit (self.extendedLib.firewall) mkTable mkRuleset mkIngressChain mkPrerouteChain mkInputChain mkForwardChain mkOutputChain mkPostrouteChain;
    inherit (self.extendedLib.fs) mkBtrfs;
    inherit (self.extendedLib.modules) mkService mkModuleTree mkModuleTree';
    inherit (self.extendedLib.secrets) mkAgenixSecret;
    inherit (self.extendedLib.systemd) hardenService mkGraphicalService mkHyprlandService;
    inherit (self.extendedLib.themes) serializeTheme compileSCSS;
  });
in {
  perSystem = {
    imports = [{_module.args.lib = extendedLib;}];
  };

  flake = {
    lib = extendedLib;
  };
}
