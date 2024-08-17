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
    (buildVimPlugin {
      pname = "precognition.nvim";
      version = "v1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "tris203";
        repo = "precognition.nvim";
        rev = "2a566f03eb06859298eff837f3a6686dfa5304a5";
        hash = "sha256-XLcyRB4ow5nPoQ0S29bx0utV9Z/wogg7c3rozYSqlWE=";
      };
    })
    (buildVimPlugin {
      pname = "btw.nvim";
      version = "2024-04-36";
      src = pkgs.fetchFromGitHub {
        owner = "letieu";
        repo = "btw.nvim";
        rev = "47f6419e90d3383987fd06e8f3e06a4bc032ac83";
        hash = "sha256-91DZUfa4FBvXnkcNHdllr82Dr1Ie+MGVD3ibwkqo04c=";
      };
    })
    (buildVimPlugin {
      pname = "comment-box.nvim";
      version = "v1.0.2";
      src = pkgs.fetchFromGitHub {
        owner = "LudoPinelli";
        repo = "comment-box.nvim";
        rev = "refs/tags/${version}";
        hash = "sha256-2P8Zyd5ucOvihZdjgSmr7YlV0yuCn+LyHkCj9gPx/CY=";
      };
    })
  ];
}