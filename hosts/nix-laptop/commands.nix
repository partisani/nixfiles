{ ... }@wm :


{
  commands = {
    term = {
      name = "Open ${wm.term.name} instance";
      command = wm.term.command;
    };

    quit = {
      name = "Close ${wm} instance";
      command = wm.commands.exit;
    };

    applauncher = {
      name = "Open an app launcher";
      aliases = [ "appl" "run" wm.app-launcher.name ];
      command = "${wm.app-launcher.command} | nu -c $in";
    };
  };

  binds = {
    
  };
 }
