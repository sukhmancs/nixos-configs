{
  programs.eza = {
    enable = true;
    icons = "always";
    git = true;
    enableZshIntegration = false;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
