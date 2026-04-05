{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nixd
    alejandra
    stylua
    biome
  ];
}
