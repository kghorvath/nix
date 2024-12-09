{ config, inputs, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/hyprland/hyprland.conf;
    plugins = [
      #pkgs.hyprlandPlugins.hyprwinwrap
#      inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];  
  };
  services.hypridle = {
    enable = true;
  };
  services.hyprpaper = {
    enable = false;
  };
  xdg.configFile."hypr/hypridle.conf".source = ../dotfiles/hyprland/hypridle.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../dotfiles/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ../dotfiles/hyprland/hyprlock.conf;
  xdg.configFile."waybar/config.top".source = ../dotfiles/waybar/config.top;
  xdg.configFile."waybar/config.bottom".source = ../dotfiles/waybar/config.bottom;
  xdg.configFile."waybar/style.css".source = ../dotfiles/waybar/style.css;

}