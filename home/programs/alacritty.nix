{ config, inputs, pkgs, ... }:

{

  programs.alacritty = {
    enable = true;
    settings = {
      cursor.style = {
        blinking = "Always";
	shape = "Block";
      };
      
      font = {
        size = 12;
        normal = {
	  family = "Cascadia Code PL";
          style = "Regular";
	};
        bold = {
	  style = "Bold";
	};
        italic = {
          style = "Italic";
	};
      };

      window = {
        dynamic_title = true;
        opacity = 0.8;
	padding = {
	  x = 10;
	  y = 10;
	};
      };
    };
  };

}