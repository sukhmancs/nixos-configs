{pkgs, ...}:
{
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "staline.nvim";
      version = "2024-02-05";
      src = pkgs.fetchFromGitHub {
        owner = "tamton-aquib";
        repo = "staline.nvim";
        rev = "d337bc9b343df3328921ef4c3f8ff604102d0201";
        hash = "sha256-HkuVio/F8HOb6k9N8LkYdQ1vheuyjrqP25RforoWZSk=";
      };
    })
    (buildVimPlugin {
      name = "hlchunk";
      src = pkgs.fetchFromGitHub {
        owner = "shellRaining";
        repo = "hlchunk.nvim";
        rev = "930fe6262f87d66ca0c85dada3bb7c2a8cb6ec3e";
        hash = "sha256-IwxyUwL10pop+Aod7BFM67JFXVY37z2Ly4EnlGPwfls=";
      };
    })
  ];
}