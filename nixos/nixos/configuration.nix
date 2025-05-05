# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command"];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    configurationLimit = 8;
    device = "nodev";
    # useOSProber = true; # Increases rebuild time
  };

  system.name = "didact";
  networking.hostName = "didact";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 3000;
      to = 3010;
    }
  ];
  # Enable DNS
  # Configure DNS servers (Cloudflare) for both IPv4 and IPv6
  networking.nameservers = [
    "1.1.1.1#cloudflare-dns.com"
    "8.8.8.8#dns.google"
    "1.0.0.1#cloudflare-dns.com"
    "8.8.4.4#dns.google"
    "2606:4700:4700::1111#cloudflare-dns.com"
    "2001:4860:4860::8888#dns.google"
    "2606:4700:4700::1001#cloudflare-dns.com"
    "2001:4860:4860::8844#dns.google"
  ];
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    dnsovertls = "opportunistic";
    domains = ["~."]; # "use as default interface for all requests"
    llmnr = "true";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false; # Use the proprietary driver
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enable bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; # Enable experimental features, useful for some devices
      };
    };
  };

  # Printers
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser # https://nixos.wiki/wiki/Printing
      cups-brother-dcpt310 # from nix-os unstable packages
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "dvorak";
  services.xserver.xkb.options = "caps:escape_shifted_capslock";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable media-controles with playerctl
  services.playerctld.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.upsher = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "networkmanager" "lp" "scanner" "storage" "adbusers"];
    description = "Upsher aka Krish Das";
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # programs.firefox.enable = true;
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   configure = {
  #     packages.myVimPackage = with pkgs.vimPlugins; {
  #       start = [nvim-treesitter];
  #     };
  #   };
  # };
  programs.thunar = {
    enable = true;
  };
  programs.java.enable = true;
  programs.lazygit.enable = true;
  programs.zsh.enable = true;
  programs.tmux.enable = true;
  programs.adb.enable = true;
  programs.nh.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  fonts.packages = with pkgs; [jetbrains-mono];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    firefox
    google-chrome
    git
    swaynotificationcenter
    libnotify
    swww
    alacritty
    ghostty
    stow
    networkmanagerapplet
    fzf
    eza
    fastfetch
    trash-cli
    bottom
    procs
    yazi
    wl-clipboard
    cliphist
    bat
    pavucontrol
    gh
    alejandra
    stylua
    gcc
    scrcpy
    fd
    unzip
    ripgrep
    ffmpeg
    wf-recorder
    mpv
    feh
    nodejs
    grim
    slurp
    tofi
    tree-sitter
    cargo
  ];

  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
