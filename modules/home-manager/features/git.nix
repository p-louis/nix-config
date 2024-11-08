{
myConfig,
...
}: {
  programs.git = {
    enable = true;
    userName = myConfig.realName;
    userEmail = myConfig.workEmail;
    signing = {
      key = "63435FF202AD8B94";
    };

    aliases = {
      c = "commit -S";
      co = "checkout";
      pu = "pull";
      p = "push";
      st = "status";
      a = "add .";
    };

    includes = [
      {
        path = "~/work/.zitisconf.git";
        condition = "gitdir:~/work/zitis.*";
      }
    ];

    lfs.enable = true;

    extraConfig = {
      pull = {
        rebase = false;
      };
      mergetool."nvim" ={
        cmd = "nvim -f -c \"Gdiffsplit!\" \"$MERGED\"";
      };
      diff = {
        tool = "nvim";
      };
      merge = {
        tool = "nvim";
      };
      mergetool = {
        prompt = false;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
