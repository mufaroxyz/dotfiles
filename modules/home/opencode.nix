{
  programs.opencode = {
    enable = true;
    settings = {
      default_agent = "build";
      small_model = "openrouter/openai/gpt-5.6-luna";
      plugin = [ "@dietrichgebert/ponytail" ];
      mcp = {
        exa = {
          type = "remote";
          url = "https://mcp.exa.ai/mcp";
          enabled = true;
          headers.x-api-key = "{env:EXA_API_KEY}";
        };
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
          enabled = true;
        };
      };
      lsp = true;
    };
  };
}
