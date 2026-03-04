{...}: {
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # kernel-level remapping
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "esc";
            esc = "capslock";
          };
        };
      };
    };
  };
}
