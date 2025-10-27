{...}: {
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
