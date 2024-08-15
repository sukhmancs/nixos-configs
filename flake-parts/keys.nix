# Original Code by NotAShelf - https://github.com/notashelf/nyx
let
  inherit (builtins) attrValues concatLists foldl' map;

  # Users
  users = {
    xi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPakhaEWcF9kSpjx1y8sjOBGd9OILZ2EVS/YaEQ+o8Z";
  };

  # Hosts
  machines = {
    triangulum = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8XojSEerAwKwXUPIZASZ5sXPPT7v/26ONQcH9zIFK+"];
    andromeda = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKAYCaA6JEnTt2BI6MJn8t2Qc3E45ARZua1VWhQpSPQi"];
    milkyway = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPShBrtrNRNaYUtIWhn0RHDr759mMcfZjqjJRAfCnWU"];
    messier = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWh3pRk2edQkELicwkYFVGKy90sFlluECfTasjCQr1m"];
  };

  # Shorthand aliases for various collections of host keys
  servers = concatLists (map (host: machines.${host}) ["triangulum"]);
  workstations = concatLists (map (host: machines.${host}) ["milkyway" "andromeda" "messier"]);

  all = foldl' (a: b: a ++ b) [users.xi] (attrValues machines);
in {
  inherit (users) xi;
  inherit (machines) triangulum andromeda milkyway messier;
  inherit servers workstations all;

  # Additional utilities
  mkGlobal = list: list ++ [users.xi];
}
