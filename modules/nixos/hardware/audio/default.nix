{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.hardware.audio;
in
{
  options.bery.hardware.audio = {
    enable = mkEnableOption "audio for the system";
    enableJack = mkEnableOption "JACK audio support";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      jack.enable = cfg.enableJack;
    };

    # explicitly disable the old PulseAudio service to ensure PipeWire takes over.
    services.pulseaudio.enable = false;
  };
}
