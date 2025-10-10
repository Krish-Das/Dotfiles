{pkgs, ...}: {
  networking = {
    hostName = "didact"; # same as hostname

    # networking.wireless.enable = true;
    networkmanager = {
      enable = true;
    };

    # Enable DNS
    # Configure DNS servers (Cloudflare) for both IPv4 and IPv6
    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "8.8.8.8#dns.google"
      "1.0.0.1#cloudflare-dns.com"
      "8.8.4.4#dns.google"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2001:4860:4860::8888#dns.google"
      "2606:4700:4700::1001#cloudflare-dns.com"
      "2001:4860:4860::8844#dns.google"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        53317 # port for LocalSend
      ];
      allowedTCPPortRanges = [
        {
          from = 3000;
          to = 3010;
        }
      ];
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "false"; # "allow-downgrade"
    dnsovertls = "false"; # "opportunistic"
    domains = ["~."]; # "use as default interface for all requests"
    llmnr = "true";
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
# ----------------------------
# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;
# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

