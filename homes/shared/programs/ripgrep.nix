#
# ripgrep - Recursively search directories for a regex pattern
#
# Usage: rg regular_expression [path ...]
#
{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Don't let ripgrep vomit really long lines to my terminal, and show a preview.
      "--max-columns=150"
      "--max-columns-preview"

      # Search hidden files or directories by default
      "--hidden"

      # ignore git files
      "--glob=!.git/*"

      # Set the colors.
      "--colors=line:none"
      "--colors=line:style:bold"

      # case insensitive search
      "--smart-case"
    ];
  };
}
