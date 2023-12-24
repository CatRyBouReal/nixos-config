{
  lib,
  pkgs,
  config,
  ...
}: {
  xsession.windowManager.i3 = let
    mod = "Mod4";
  in {
    enable = true;

    config = {
      modifier = mod;

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";

          fonts = {
            names = ["Ubuntu Mono"];
            size = 14.0;
          };
        }
      ];

      fonts = {
        names = ["Ubuntu Mono"];
	size = 12.0;
      };
    };
  };
}
