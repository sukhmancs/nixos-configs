{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.strings) fileContents;
in {
  programs.zsh = {
    completionInit = ''
      # Load compinit
      autoload -U compinit
      zmodload zsh/complist

      _comp_options+=(globdots)
      zcompdump="$XDG_DATA_HOME"/zsh/.zcompdump-"$ZSH_VERSION"-"$(date --iso-8601=date)"
      compinit -d "$zcompdump"

      # Recompile zcompdump if it exists and is newer than zcompdump.zwc
      # compdumps are marked with the current date in yyyy-mm-dd format
      # which means this is likely to recompile daily
      # also see: <https://htr3n.github.io/2018/07/faster-zsh/>
      if [[ -s "$zcompdump" && (! -s "$zcompdump".zwc || "$zcompdump" -nt "$zcompdump".zwc) ]]; then
        zcompile "$zcompdump"
      fi

      # Load bash completion functions.
      autoload -U +X bashcompinit && bashcompinit

      ${fileContents ./rc/comp.zsh}
    '';
  };
}
