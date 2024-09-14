{
  wayland.windowManager.hyprland.settings = {
    input = {
      # keyboard layout
      kb_layout = "us,us";
      # yes, i use dvorak
      kb_variant = "dvorak,";

      repeat_delay = 250;
      repeat_rate = 35;

      follow_mouse = 1;
      # do not imitate natural scroll
      touchpad = {
        natural_scroll = "no";
        # disable_while_typing = true;
        # clickfinger_behavior = true;
        # scroll_factor = 0.5;
      };
      special_fallthrough = true;
      # ez numlock enable
      numlock_by_default = true;
    };
  };
}
