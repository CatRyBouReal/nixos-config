# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./firefox.nix
    ./i3.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.nur-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "catrybou";
    homeDirectory = "/home/catrybou";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  home.packages = with pkgs; [
    ubuntu_font_family

    nvidia-offload
  ];

  home.file = {
    ".background-image".source = ./wallpaper.jpg;
  };

  fonts.fontconfig.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;

  programs.bash.enable = true;

  # Enable and configure git
  programs.git = {
    enable = true;
    userName = "Anish Vundela";
    userEmail = "anishreddyvundela@proton.me";
  };

  # Enable GitHub CLI
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.alacritty.enable = true;

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;

    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };

    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
  };

  qt = {
    enable = true;

    platformTheme = "gtk3";

    style = {
      name = "gtk2";
    };
  };

  programs.direnv = {
    enable = true;

    package = pkgs.unstable.direnv;

    nix-direnv = {
      enable = true;

      package = pkgs.unstable.direnv;
    };
  };

  services.picom = {
    enable = true;
    vSync = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
