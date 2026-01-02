{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    adcli
    realmd
    samba
  ];

  security = {
    krb5 = {
      enable = true;
      settings = {
        libdefaults = {
          udp_preference_limit = 0;
          default_realm = "DIR.SATHANI.COM";
        };
      };
    };

    pam = {
      makeHomeDir.umask = "077";
      services.login.makeHomeDir = true;
      services.sshd.makeHomeDir = true;
    };

    sudo = {
      extraConfig = ''
        %workstation\ admins ALL=(ALL:ALL) NOPASSWD: ALL
      '';
    };
  };

  services = {
    resolved.enable = true;
    realmd.enable = true;
    sssd = {
    enable = true;
      config = ''
        [sssd]
        domains = dir.sathani.com 
        config_file_version = 2
        services = nss, pam

        [pam]
        offline_credentials_expiration = 365

        [domain/dir.sathani.com]
        krb5_store_password_if_offline = true
        cache_credentials = true
        account_cache_expiration = 365
        entry_cache_timeout = 14400
        krb5_realm = DIR.SATHANI.COM 
        realmd_tags = manages-system joined-with-samba
        id_provider = ad
        fallback_homedir = /home/%u
        ad_domain = dir.sathani.com
        use_fully_qualified_names = false
        ldap_id_mapping = false
        auth_provider = ad
        access_provider = ad
        chpass_provider = ad
        ad_gpo_access_control = permissive
        enumerate = true
        override_shell = /run/current-system/sw/bin/fish
      '';
    };
  };

}
