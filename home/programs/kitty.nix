{ config, inputs, pkgs, ... }:

{

  programs.kitty = {
    enable = true;
    settings = {
      linux_display_server = "x11";

      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = -1;
      cursor_stop_blinking_after = 0;
      cursor_trail = 1;

      font_size = 12;
      font_family = "Cascadia Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      background = "#131416";
      background_opacity = 0.8;

      remember_window_size = "yes";
      initial_window_width = "105c";
      initial_window_height = "28c";

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      allow_hyperlinks = "yes";
      shell_integration = "no-cursor";
    };
  };

}