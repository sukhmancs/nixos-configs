# Original Code by NotAShelf - https://github.com/notashelf/nyx
let
  inherit (builtins) attrValues concatLists foldl' map;

  # Users
  users = {
    xi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPakhaEWcF9kSpjx1y8sjOBGd9OILZ2EVS/YaEQ+o8Z";
  };

  # Hosts
  machines = {
    triangulum = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+dY4XHY89Ph78gwPvQDs+RnptZX0s+qhaf+ACL52Tv"];
    andromeda = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKAYCaA6JEnTt2BI6MJn8t2Qc3E45ARZua1VWhQpSPQi"];
    milkyway = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPShBrtrNRNaYUtIWhn0RHDr759mMcfZjqjJRAfCnWU"];
  };

  # Shorthand aliases for various collections of host keys
  servers = concatLists (map (host: machines.${host}) ["triangulum"]);
  workstations = concatLists (map (host: machines.${host}) ["milkyway" "andromeda"]);

  all = foldl' (a: b: a ++ b) [users.xi] (attrValues machines);
in {
  inherit (users) xi;
  inherit (machines) triangulum andromeda milkyway;
  inherit servers workstations all;

  # Additional utilities
  mkGlobal = list: list ++ [users.xi];
}
