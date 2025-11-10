{ pkgs, inputs,  ... }: {
  age.secrets.syncthing-cert = {
    file = ./secrets/titan/syncthing/cert.pem.age;
    group = "users";
    owner = "henrik";
  };

  age.secrets.syncthing-key = {
    file = ./secrets/titan/syncthing/key.pem.age;
    group = "users";
    owner = "henrik";
  };

  services.syncthing = {
    enable = true;
    group = "users";
    user = "henrik";
    configDir = "/home/henrik/.config/syncthing";
    dataDir = "/home/henrik/Sync";
    key = config.age.secrets.syncthing-key.path;
    cert = config.age.secrets.syncthing-cert.path;
    settings = {
      openDefaultPorts = true;
      devices = {
        "fatshark" = { id = "IFSKHIE-ZDHMFIL-5JLMN5K-SJO4BZ3-3LFZWU4-P6DRFF2-QPDOAEE-DM5XCA7"; } ;
      };
      folders = {
        "Documents" = {
          path = "/home/henrik/Documents";
          devices = [ "fatshark" ];
        };
        "Videos" = {
          path = "/home/henrik/Videos";
          devices = [ "fatshark" ];
        };
        "Pictures" = {
          path = "/home/henrik/Pictures";
          devices = [ "fatshark" ];
        };
      };
    };
  };
}
