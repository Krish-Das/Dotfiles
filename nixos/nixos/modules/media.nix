{...}: {
  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    wireplumber.extraConfig."51-disable-pro-audio" = {
      "monitor.alsa.rules" = [
        {
          matches = [{"device.name" = "alsa_card.pci-0000_01_00.1";}];
          actions.update-props = {
            "api.alsa.use-acp" = true;
            "api.acp.auto-profile" = true;
          };
        }
        {
          matches = [{"device.name" = "alsa_card.pci-0000_00_1b.0";}];
          actions.update-props = {
            "api.alsa.use-acp" = true;
            "api.acp.auto-profile" = true;
          };
        }
      ];
    };
  };

  # Enable media-controles with playerctl
  services.playerctld.enable = true;
}
