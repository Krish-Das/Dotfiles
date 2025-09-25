# User accounts configuration
{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.upsher = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["wheel" "video" "audio" "networkmanager" "lp" "scanner" "storage" "adbusers"];
    description = "Upsher aka Krish Das";
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Note: /shared volume is configured separately in modules/shared.nix
  # This ensures that 'upsher' has full ownership of the /shared directory
}
