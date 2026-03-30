{
  users.users.jay = {
    isNormalUser = true;
    description = "jay";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout"
    ];
  };
}
