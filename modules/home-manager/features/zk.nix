{
...
}: {
  programs.zk = {
    enable = true;
    settings = {
      note = {
        language = "en";
        template = "default.md";
        default-title = "Untitled";
        extension = "md";
        filename = "{{id}} - {{slug-title}}";
      };
      extra = {};
      format.markdown = {
        hashtags = false;
        colon-tags = true;
        multiword-tags = false;
      };

      tool = {
        editor = "nvim";
        fzf-preview = "bat -p --color always {-1}";
      };

      lsp = {
        diagnostics = {
          dead-link = "error";
        };
        completion = {

        };
      };
      filter = {};
      alias = {};
    };
  };
}
