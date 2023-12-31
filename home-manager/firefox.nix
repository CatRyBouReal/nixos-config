{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.catrybou = {
      settings = {
        "browser.download.panel.shown" = true;
      };

      search.default = "StartPage";

      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };
        "StartPage" = {
          urls = [
            {
              template = "https://startpage.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          definedAliases = ["@sp"];
        };
      };

      search.force = true;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        sponsorblock
        multi-account-containers
      ];

      containers = {
        personal = {
          id = 1;
          name = "Personal";
          icon = "fingerprint";
          color = "blue";
        };
        school = {
          id = 2;
          name = "School";
          icon = "briefcase";
          color = "orange";
        };
      };
    };
  };
}
