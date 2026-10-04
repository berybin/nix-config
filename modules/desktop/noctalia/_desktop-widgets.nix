{
  enabled = true;
  grid = {
    cell_size = 16;
    major_interval = 4;
    visible = true;
  };

  widget_order = [
    "timer"
    "calendar"
  ];

  widget.timer = {
    box_height = 208.0;
    box_width = 384.0;
    cx = 3192.0;
    cy = 696.0;
    output = "DP-2";
    placement_height = 1440.0;
    placement_width = 3440.0;
    rotation = 0.0;
    type = "noctalia/timer:desktop";
  };

  widget.calendar = {
    box_height = 432.0;
    box_width = 384.0;
    cx = 3192.0;
    cy = 304.0;
    output = "DP-2";
    placement_height = 1440.0;
    placement_width = 3440.0;
    rotation = 0.0;
    type = "calendar";
    settings = {
      show_events = false;
      show_week_numbers = false;
    };
  };
}
