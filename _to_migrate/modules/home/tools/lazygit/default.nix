{
  lib,
  config,
  ...
}:
with lib;
with lib.bery;
let
  cfg = config.bery.tools.lazygit;
in
{
  options.bery.tools.lazygit = {
    enable = mkEnableOption "lazygit";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        customCommands = [
          {
            key = "C";
            command = "if [ -z {{ .Form.Summary }}]; then\n  echo \"a summary is required\"\n  exit 1\nelse\n  git commit -m \"{{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}: {{ .Form.Summary }}\"{{ if .Form.Description }} -m \"{{ .Form.Description }}\"{{ end }}\nfi\n";
            description = "commit using the conventional commits format";
            context = "files";
            prompts = [
              {
                type = "menu";
                title = "Select the type of change you are committing.";
                key = "Type";
                options = [
                  {
                    name = "Feature";
                    description = "a new feature";
                    value = "feat";
                  }
                  {
                    name = "Fix";
                    description = "a bug fix";
                    value = "fix";
                  }
                  {
                    name = "Documentation";
                    description = "documentation only changes";
                    value = "docs";
                  }
                  {
                    name = "Style";
                    description = "changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)";
                    value = "style";
                  }
                  {
                    name = "Refactor";
                    description = "a code change that neither fixes a bug nor adds a feature";
                    value = "refactor";
                  }
                  {
                    name = "Performance Improvement";
                    description = "a code change that improves performance";
                    value = "perf";
                  }
                  {
                    name = "Test";
                    description = "adding missing tests or correcting existing tests";
                    value = "test";
                  }
                  {
                    name = "Build";
                    description = "changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)";
                    value = "build";
                  }
                  {
                    name = "CI";
                    description = "changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)";
                    value = "ci";
                  }
                  {
                    name = "Chore";
                    description = "other changes that don't modify src or test files";
                    value = "chore";
                  }
                  {
                    name = "Revert";
                    description = "reverts a previous commit";
                    value = "revert";
                  }
                  {
                    name = "WIP";
                    description = "work in progress";
                    value = "wip";
                  }
                  {
                    name = "Security Updates";
                    description = "changes and dependency updates that address security vulnerabilities";
                    value = "sec";
                  }
                  {
                    name = "Dependency Updates";
                    description = "updates to dependencies";
                    value = "deps";
                  }
                ];
              }
              {
                type = "input";
                title = "What is the scope of this change? (e.g. component or file name): (press enter to skip)";
                key = "Scopes";
              }
              {
                type = "input";
                title = "Write a short, imperative tense summary of the change";
                key = "Summary";
              }
              {
                type = "input";
                title = "Provide a longer description of the change: (press enter to skip)";
                key = "Description";
              }
              {
                type = "confirm";
                title = "Is the commit message correct?";
                body = "{{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}: {{ .Form.Summary }}{{if .Form.Description}}\n{{ .Form.Description }}{{end}}";
              }
            ];
          }
        ];
      };
    };
  };
}
