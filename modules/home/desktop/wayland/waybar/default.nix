{
  lib,
  pkgs, # An instance of `pkgs` with your overlays and packages applied is also available.
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.desktop.wayland.waybar;
in
{
  options.bery.desktop.wayland.waybar = {
    enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      style = ./style.css;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";

          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "clock#date"
            "clock"
          ];
          modules-right = [
            "group/sys-info"
            "battery"
            "pulseaudio"
            "custom/keyboard-backlight"
            "backlight"
            "tray"
          ];

          "hyprland/workspaces" = {
            format = "[{icon}] {windows}";
            format-icons = {
              "1" = "main";
              "2" = "dev";
            };
            persistent-workspaces = {
              "*" = 2;
            };

            all-outputs = true;
            # format-window-separator = "|";
            window-rewrite-default = " ";
            window-rewrite = {
              "title<.*youtube.*>" = " ";
              "title<.*github.*>" = "󰊤 ";
              "class<.*zen.*>" = "󰖟 ";

              kitty = " ";
              "class<.*vim.*>" = " ";
            };
          };

          "hyprland/window" = {
            format = "{class} - {title}";
            icon = true;
          };

          battery = {
            interval = 10;
            format = "{icon} {capacity}%";
            format-charging = "{icon} {capacity}% ";
            format-icons = [
              "󰁺 [█░░░░░░░░░]"
              "󰁻 [██░░░░░░░░]"
              "󰁼 [███░░░░░░░]"
              "󰁽 [████░░░░░░]"
              "󰁾 [█████░░░░░]"
              "󰁿 [██████░░░░]"
              "󰂀 [███████░░░]"
              "󰂁 [████████░░]"
              "󰂂 [█████████░]"
              "󰁹 [██████████]"
            ];
            states = {
              medium = 50;
              warning = 30;
              low = 15;
              critical = 10;
            };
          };

          clock = {
            interval = 1;
            format = "  {:%H:%M:%S}";
            tooltip = false;
          };

          "clock#date" = {
            interval = 60;
            format = "󰃭 {:%d %b, %Y}";
            tooltip = false;
          };

          network = {
            format-wifi = "  {essid} ({signalStrength}%)";
            tooltip-format-wifi = lib.concatLines [
              "interface: {ifname}"
              "ip: {ipaddr}/{cidr}"
            ];

            format-ethernet = "󰈀 {ifname}";
            tooltip-format-ethernet = lib.concatLines [
              "ip: {ipaddr}/{cidr}"
              "netmask: {netmask}"
            ];

            format-disconnected = " disconnected";
          };

          tray = {
            icon-size = 21;
            spacing = 10;
          };

          pulseaudio = {
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            format = "{icon} {volume}%";
            format-muted = "  0%";
            scroll-step = 1;
            format-icons = {
              default = [
                " "
                " "
              ];
            };
          };

          "group/sys-info" = {
            modules = [
              "custom/sys-info-wrapper"
              "cpu"
              "disk"
              "memory"
              "network"
            ];
            orientation = "inherit";
            transition-left-to-right = false;
            drawer = {
              transition-duration = 500;
            };
          };

          "custom/sys-info-wrapper" = {
            format = " sys";
            tooltip = false;
          };

          disk = {
            interval = 30;
            format = " {percentage_used}% on /";
          };

          cpu = {
            interval = 10;
            format = " {usage}%";
          };

          memory = {
            interval = 30;
            format = "  {percentage}%";
            tooltip-format = lib.concatLines [
              "{used} / {total} GiB used"
              "swap used: {swapPercentage}%"
            ];
          };

          "backlight" = {
            format = "󰍹 {percent}%";
          };

          # TODO: make this more dynamic
          "custom/keyboard-backlight" = {
            format = " ";
            on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl -d tpacpi::kbd_backlight -q set 50%+";
            on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl -d tpacpi::kbd_backlight -q set 50%-";

            on-click = "${pkgs.brightnessctl}/bin/brightnessctl -d tpacpi::kbd_backlight -q set 50%+";
            on-click-right = "${pkgs.brightnessctl}/bin/brightnessctl -d tpacpi::kbd_backlight -q set 50%-";
            tooltip-format = "Keyboard Backlight (scoll to change)";
          };

          "custom/lock" = {
            format = "󰍁";
            tooltip = false;
            on-click = "";
          };
          "custom/reboot" = {
            format = "󰜉";
            tooltip = false;
            on-click = "reboot";
          };
          "custom/power" = {
            format = " ";
            tooltip = false;
            on-click = "shutdown now";
          };
        };
      };
    };
  };
}
