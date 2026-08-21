{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  localSkills = {
    frontend = ./skills/frontend;
    memory = ./skills/memory;
    review = ./skills/review;
    security-research = ./skills/security-research;
  };

  sharedSkills = {
    audit-context-building =
      inputs.trailofbits-skills + "/plugins/audit-context-building/skills/audit-context-building";
    better-accessibility = inputs.jakubkrehel-skills + "/skills/better-accessibility";
    better-colors = inputs.jakubkrehel-skills + "/skills/better-colors";
    better-interface = inputs.jakubkrehel-skills + "/skills/better-interface";
    better-layout = inputs.jakubkrehel-skills + "/skills/better-layout";
    better-typography = inputs.jakubkrehel-skills + "/skills/better-typography";
    better-ui = inputs.jakubkrehel-skills + "/skills/better-ui";
    better-writing = inputs.jakubkrehel-skills + "/skills/better-writing";
    codeql = inputs.trailofbits-skills + "/plugins/static-analysis/skills/codeql";
    differential-review =
      inputs.trailofbits-skills + "/plugins/differential-review/skills/differential-review";
    animate = inputs.emilkowalski-skills + "/skills/animate";
    animation-vocabulary = inputs.emilkowalski-skills + "/skills/animation-vocabulary";
    apple-design = inputs.emilkowalski-skills + "/skills/apple-design";
    find-skills = inputs.vercel-skills + "/skills/find-skills";
    find-animation-opportunities = inputs.emilkowalski-skills + "/skills/find-animation-opportunities";
    fp-check = inputs.trailofbits-skills + "/plugins/fp-check/skills/fp-check";
    hugeicons = inputs.hugeicons + "/skills/hugeicons";
    improve-animations = inputs.emilkowalski-skills + "/skills/improve-animations";
    insecure-defaults =
      inputs.trailofbits-skills + "/plugins/insecure-defaults/skills/insecure-defaults";
    review-animations = inputs.emilkowalski-skills + "/skills/review-animations";
    semgrep = inputs.trailofbits-skills + "/plugins/static-analysis/skills/semgrep";
    supply-chain-risk-auditor =
      inputs.trailofbits-skills + "/plugins/supply-chain-risk-auditor/skills/supply-chain-risk-auditor";
    variant-analysis = inputs.trailofbits-skills + "/plugins/variant-analysis/skills/variant-analysis";
  };
in
{
  programs.mcp = {
    enable = true;
    servers = {
      context7 = {
        url = "https://mcp.context7.com/mcp";
        enabled = true;
      };
    };
  };

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    skills = localSkills;
    settings = {
      default_agent = "build";
      small_model = "openrouter/deepseek/deepseek-v4-flash-0731";
      plugin = [ "file://${inputs.ponytail}/.opencode/plugins/ponytail.mjs" ];
      mcp.exa = {
        type = "remote";
        url = "https://mcp.exa.ai/mcp";
        enabled = true;
        headers.x-api-key = "{env:EXA_API_KEY}";
      };
      lsp = true;
    };
  };

  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    skills = localSkills // {
      handoff = ./skills/handoff;
      init-deep = ./skills/init-deep;
    };
    plugins = [ inputs.ponytail ];
    settings = {
      model_provider = "openrouter";
      model = "openai/gpt-5.6-sol";
      model_reasoning_effort = "high";
      mcp_servers.exa = {
        url = "https://mcp.exa.ai/mcp";
        enabled = true;
        env_http_headers.x-api-key = "EXA_API_KEY";
      };
      model_providers.openrouter = {
        name = "OpenRouter";
        base_url = "https://openrouter.ai/api/v1";
        wire_api = "responses";
        env_key = "OPENROUTER_API_KEY";
      };
    };
  };

  home = {
    packages = [ pkgs.nodejs ];
    # ponytail: replace directories created by the skills CLI during the Nix migration.
    activation.cleanManagedSkillDirectories = lib.hm.dag.entryBefore [ "linkGeneration" ] ''
      for name in ${lib.escapeShellArgs (lib.attrNames sharedSkills)}; do
        path="$HOME/.agents/skills/$name"
        if [ -d "$path" ] && [ ! -L "$path" ]; then
          run rm -rf "$path"
        fi
      done

      for name in ${lib.escapeShellArgs (lib.attrNames localSkills)}; do
        path="$HOME/.config/opencode/skills/$name"
        if [ -d "$path" ] && [ ! -L "$path" ]; then
          run rm -rf "$path"
        fi
      done
    '';
    file =
      lib.mapAttrs' (
        name: source:
        lib.nameValuePair ".agents/skills/${name}" {
          inherit source;
          force = true;
        }
      ) sharedSkills
      // {
        ".codex/config.toml".force = true;
      };
  };

  xdg.configFile = lib.mapAttrs' (
    name: _: lib.nameValuePair "opencode/skills/${name}" { force = true; }
  ) localSkills;
}
