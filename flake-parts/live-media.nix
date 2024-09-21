{
  inputs,
  self,
  ...
}: {
  # Build ISO image by running `nix build .#images.<hostname>`
  flake.images = {
    # Installation iso
    messier = self.nixosConfigurations."messier".config.system.build.isoImage;
    nebula = self.nixosConfigurations."nebula".config.system.build.isoImage;
  };
}
