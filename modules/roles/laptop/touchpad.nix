#
# libinput - touchpad and mouse settings
#
{
  config = {
    services = {
      xserver.exportConfiguration = true;
      libinput = {
        # enable libinput
        enable = true;

        # disable mouse acceleration
        mouse = {
          accelProfile = "flat";
          accelSpeed = "0";
          middleEmulation = false;
        };

        # touchpad settings
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          clickMethod = "clickfinger";
          horizontalScrolling = false;
          disableWhileTyping = true;
        };
      };
    };
  };
}
