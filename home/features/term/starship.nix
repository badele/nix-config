# ███████╗████████╗ █████╗ ██████╗ ███████╗██╗  ██╗██╗██████╗ 
# ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║  ██║██║██╔══██╗
# ███████╗   ██║   ███████║██████╔╝███████╗███████║██║██████╔╝
# ╚════██║   ██║   ██╔══██║██╔══██╗╚════██║██╔══██║██║██╔═══╝ 
# ███████║   ██║   ██║  ██║██║  ██║███████║██║  ██║██║██║     
# ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝     

# Search font symbol => https://www.nerdfonts.com/cheat-sheet
# Configuration => https://starship.rs/config/
{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      right_format = "[](#33658A)$time";

      character = {
        success_symbol = "[✅](bold green)";
        error_symbol = "[❌](bold red)";
      };

      format = ''$shlvl$username$hostname[](bg:#DA627D fg:#9A348E)$directory[](fg:#DA627D bg:#FCA17D)$git_branch$git_status[](fg:#FCA17D bg:#86BBD8)$c$golang[](fg:#86BBD8 bg:#06969A)$docker_context$vagrant[](fg:#06969A bg:#33658A)$cmd_duration[ ](fg:#33658A)'';
      fill = {
        symbol = " ";
        disabled = false;
      };

      username = {
        style_user = "bg:#9A348E";
        style_root = "bg:#ef0f17";
        format = "[](fg:#ef0f17)[$user]($style)";
        show_always = true;
      };

      hostname = {
        format = "[@$hostname]($style)";
        ssh_only = false;
        style = "bg:#9A348E";
      };

      shlvl = {
        format = "[#]($style)[$shlvl ]($style)";
        style = "bg:#9A348E";
        threshold = 2;
        repeat = true;
        disabled = false;
      };


      directory = {
        style = "bg:#DA627D";
        format = "[ $path ]($style)";
        # truncation_length = 3;
        # truncation_symbol = "…/";

        substitutions = {
          "Documents" = " ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };

      };

      git_branch = {
        symbol = "";
        style = "bg:#FCA17D";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#FCA17D";
        format = "[$all_status$ahead_behind ]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:#86BBD8";
        format = "[ $symbol ($version) ]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bg:#06969A";
        format = "[ $symbol $context ]($style) $path";
      };

      vagrant = {
        symbol = " ";
        style = "bg:#06969A";
        format = "[ $symbol  $version ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#33658A";
        format = "[  $time ]($style)";

      };

      cmd_duration = {
        disabled = false;
        style = "bg:#33658A";
        format = "[ 祥 $duration ]($style)";
      };
    };
  };
}
