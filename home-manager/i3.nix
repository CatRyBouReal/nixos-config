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

      keybindings = {
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+q" = "exit";
	"${mod}+Shift+r" = "restart";

        "${mod}+Shift+c" = "kill";

        "${mod}+Shift+Return" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

        "${mod}+r" = "mode resize";

        "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-";
        "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
      };

      modes = {
        resize = {
          j = "resize grow height 10 px or 10 ppt";
          Escape = "mode default";
          h = "resize shrink width 10 px or 10 ppt";
          Return = "mode default";
          l = "resize grow width 10 px or 10 ppt";
          k = "resize shrink height 10 px or 10 ppt";
        };
      };
    };
  };
}
