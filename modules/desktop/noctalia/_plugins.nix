{
  enabled = [
    "noctalia/bongocat"
    "noctalia/notes"
    "noctalia/screen_recorder"
    "noctalia/timer"
  ];

  auto_update = "all";

  source = [
    {
      name = "official";
      kind = "git";
      location = "https://github.com/noctalia-dev/official-plugins";
      enabled = true;
    }
  ];
}
