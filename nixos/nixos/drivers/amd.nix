{pkgs, ...}: {
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };
  environment.sessionVariables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
  environment.systemPackages = with pkgs; [
    radeontop
    # rocmPackages.rocm-smi
    # glmark2 # for benchmarking the GPU
  ];
}
