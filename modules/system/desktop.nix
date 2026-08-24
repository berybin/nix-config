{ self, ... }: {
  flake.modules.nixos.system-desktop = {
    imports = [ self.modules.nixos.system-core ];

    networking.networkmanager.enable = true;

    # NOTE: Enable Audio
    security.rtkit.enable = true;
    # explicitly disable the old PulseAudio service to ensure PipeWire takes over.
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
