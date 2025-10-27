{pkgs, ...}: {
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
  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
