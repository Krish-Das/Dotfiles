# Configuration for the /shared volume
{pkgs, ...}: {
  # Mount /shared reliably using UUID (device names may change)
  fileSystems."/shared" = pkgs.lib.mkForce {
    # Use 'sudo blkid' to get the UUID of your disk
    device = "UUID=69CF-D38B"; # UUID of the exFAT partition
    fsType = "exfat"; # File system type
    # Mount options:
    #   uid=1000 -> make 'upsher' the owner (check users.users.<user>.uid)
    #   gid=100  -> assign to 'users' group
    #   umask=0077 -> only owner can read/write/execute
    options = ["uid=1000" "gid=100" "umask=0077"];
  };
}
