{...}: {
  services.syncthing = {
    enable = true;
    user = "upsher";
    dataDir = "/home/upsher";
    configDir = "/home/upsher/.config/syncthing";
    openDefaultPorts = true; # opens 22000/tcp+udp, 21027/udp

    settings = {
      gui = {
        enabled = true;
        address = "127.0.0.1:8384";
      };
      options = {
        localAnnounceEnabled = true; # LAN discovery
        globalAnnounceEnabled = false; # no relay/external
        relaysEnabled = false;
        urAccepted = -1; # disable telemetry
      };
    };
  };

  # Create ~/Sync
  systemd.tmpfiles.rules = [
    "d /home/upsher/Sync 0755 upsher users -"
  ];

  networking.firewall = {
    allowedTCPPorts = [22000];
    allowedUDPPorts = [22000 21027];
  };
}
