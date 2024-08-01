{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libnotify
    (import ./misc/infoscript.nix {inherit pkgs;})
    (import ./misc/osd.nix {inherit pkgs;})
  ];
}
