{ pkgs, ... }:

{
  home-manager.users.anegrel =
    { ... }:
    {
      home.packages = with pkgs; [ my.ask-ai ];

      zshrc.scripts = {
        "ask-ai".text = ''
          alias ,=askai
          ,t() {
            askai "Your an experienced sysadmin focused on bash scripting, linux.
          When asked a question, answer it as follows:

          ---start
          Question: how to list files
          Answer:
          # To display everything in <dir>, excluding hidden files:
          $ ls
          # List all files, including hidden files:
          # This is how you list all files including hidden one.
          $ ls -a
          # Long format list (permissions, ownership, size, and modification date) of all files:
          $ ls -a
          ---end

          Don't explain things, just answer the question and write commands.

          Question: $@
          Answer:
          "
                  }
        '';
      };
    };
}
