{pkgs, ...}: {
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    description = "Add Flathub remote for Flatpak";

    # Run after the network is up and start during normal boot
    wantedBy = ["multi-user.target"];
    after = ["network-online.target" "flatpak-system-helper.service"];
    wants = ["network-online.target"];

    path = [pkgs.flatpak];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
