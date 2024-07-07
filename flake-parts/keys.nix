let
  inherit (builtins) attrValues concatLists foldl' map;

  # Users
  users = {
    xi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPakhaEWcF9kSpjx1y8sjOBGd9OILZ2EVS/YaEQ+o8Z";
  };

  # Hosts
  machines = {
    helios = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8XojSEerAwKwXUPIZASZ5sXPPT7v/26ONQcH9zIFK+"];
    enyo = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKAYCaA6JEnTt2BI6MJn8t2Qc3E45ARZua1VWhQpSPQi"];
    hermes = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEPShBrtrNRNaYUtIWhn0RHDr759mMcfZjqjJRAfCnWU"];
    icarus = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWh3pRk2edQkELicwkYFVGKy90sFlluECfTasjCQr1m"];
    leto = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCUnniOytg/quJOjQnRFpUG3HYX0BRmKPEqQ/INpekVT0RA6jibAR+INZiydrFqYTejCJrj0l47DBjfbpzg7JbsCmI7riQNVadadxKhwjGoDXoeYUafZ+U+u1GLx6o822kClVIbW/WqyUPfXnEpjrhf74UPAARmU3kLrbum8Aule/fvrU/T+nVfsypkWO5SBddtL5p204LoRUxHVXTVxQJIGkyPfdxUzp6+vzKJ2TRiGLycWbPNG/Idfu8VS/G4lkYBaG/znl5bJ0HVgYLXiCtGvkn80qUhzDJtyygK77VKY94uGTKe/HmeNdsSRc8aXeeFUc4MvDNHO52UqYvyI/N7yjtzOlri7EUyGLk8DvChbwDELqO5AEjits4UAG+YI6Q81yYUfM0akhnTFbHLFSBY18QBvXdw1kA98Iz0bPmIcnH1ABMxdayeiHLuV1P4D8k4GMlRu9jQUampuhYKQ8nx9jFqYb85tYMi9dzGolYAZghU4//zywyVoMG25z6+M2QzztQtDmLVlgjaX8F1kbVTrBkXBTSIdsl7B/DmV28G7utRnhGoA0mjLUmdrjyIP70jpQckqkT2wRT038tA6Lq6ZD/IlZlx4/xAGCwT9nHR6S+jfJYV9AtWBruOzHf2AQbnmsuLXkQZrF1X0Wo+bhXVYIILx36e/x6GgA2awS1fFw=="];
  };

  # Shorthand aliases for various collections of host keys
  servers = concatLists (map (host: machines.${host}) ["helios" "icarus" "leto"]);
  workstations = concatLists (map (host: machines.${host}) ["enyo" "hermes" "icarus"]);

  all = foldl' (a: b: a ++ b) [users.xi] (attrValues machines);
in {
  inherit (users) xi;
  inherit (machines) helios enyo hermes icarus leto;
  inherit servers workstations all;

  # Additional utilities
  mkGlobal = list: list ++ [users.xi];
}
