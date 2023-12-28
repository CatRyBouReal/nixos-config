# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  environment.systemPackages = with pkgs; [
    sddm-chili-theme
    bibata-cursors
  ];

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Enable bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set hostname
  networking.hostName = "NixBox";

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Europe/London";

  # Set hardware clock to local time
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_GB.UTF-8";

  programs.dconf.enable = true;

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u22b.psf.gz";
    packages = with pkgs; [terminus_font];

    keyMap = "uk";
  };

  services.xserver = {
    enable = true;

    xkb.layout = "gb";

    libinput.enable = true;

    displayManager.sddm = {
      enable = true;

      theme = "chili";

      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Classic";
        };
      };
    };

    windowManager.i3 = {
      enable = true;
    };

    excludePackages = with pkgs; [
      xterm
    ];
  };

  # NVIDIA Support
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable pipewire
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  users.users = {
    catrybou = {
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
