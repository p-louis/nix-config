{pkgs, lib, config, ...}: 
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    slack webex
    khal neomutt notmuch afew
    newsboat
    mpv ncmpcpp mpd
    dunst hyprpaper eww libsForQt5.polkit-kde-agent socat
    vdirsyncer
    gcc9
    yubikey-personalization
    openssl
    fido2luks
    obs-studio
    networkmanager-openvpn
    openvpn
  ];

  services = {
    openvpn.servers = {
      iq-sirius = {
        config = ''
          client
          proto udp
          remote 193.30.84.9 1194
          dev tun
          nobind
          persist-key
          persist-tun
          remote-cert-eku "TLS Web Server Authentication"
          verify-x509-name sirius.altara.zitis.lan name
          tun-mtu 1500
          tun-mtu-extra 32
          mssfix 1450
          resolv-retry infinite
          reneg-sec 14400
          auth-user-pass
          auth-nocache
          comp-lzo
          tls-client
          tls-version-min 1.2
          auth-user-pass /home/fuzzel/vpn/zitis/credentials
          ca /home/fuzzel/vpn/zitis/iq-sirius-ca.pem
          cert /home/fuzzel/vpn/zitis/iq-sirius-cert.pem
          key /home/fuzzel/vpn/zitis/iq-sirius-key.pem
          tls-crypt /home/fuzzel/vpn/zitis/iq-sirius-tls-crypt.pem
        '';
        autoStart = false;
        updateResolvConf = true;
      };
    };
  };

}
# vim: ts=2 sts=2 sw=2 et
