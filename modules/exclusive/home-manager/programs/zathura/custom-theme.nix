{osConfig, ...}: let
  inherit (osConfig) modules;
  inherit (modules.themes) colors;
in ''
  set default-fg                #${colors.base05}
  set default-bg 			          #${colors.base00}

  set completion-bg		          #${colors.base02}
  set completion-fg		          #${colors.base05}
  set completion-highlight-bg	  #${colors.base03}
  set completion-highlight-fg	  #${colors.base05}
  set completion-group-bg		    #${colors.base02}
  set completion-group-fg		    #${colors.base07}

  set statusbar-fg		          #${colors.base05}
  set statusbar-bg		          #${colors.base00}

  set notification-bg		        #${colors.base00}
  set notification-fg		        #${colors.base05}
  set notification-error-bg	    #${colors.base00}
  set notification-error-fg	    #${colors.base08}
  set notification-warning-bg	  #${colors.base00}
  set notification-warning-fg	  #${colors.base0A}

  set inputbar-fg			          #${colors.base05}
  set inputbar-bg 		          #${colors.base00}

  set recolor                   "true"
  set recolor-lightcolor		    #${colors.base01}
  set recolor-darkcolor		      #${colors.base05}

  set index-fg			            #${colors.base05}
  set index-bg			            #${colors.base01}
  set index-active-fg		        #${colors.base05}
  set index-active-bg		        #${colors.base00}

  set render-loading-bg		      #${colors.base01}
  set render-loading-fg		      #${colors.base05}

  set highlight-color		        #${colors.base02}
  set highlight-fg              #${colors.base0F}
  set highlight-active-color	  #${colors.base0F}
''
