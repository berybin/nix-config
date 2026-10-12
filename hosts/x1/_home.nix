{
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "25.05";
    persistence."/persist" = {
      hideMounts = true;
      directories = [
        "Desktop"
        "Documents"
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];

    };
  };

}
