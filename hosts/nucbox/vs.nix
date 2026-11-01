{

  flake.modules.nixos.nucbox = { lib, config, ... }: {
    services.vintagestory-server = {
      enable = true;
      port = config.berynet.vintagestory.port;
      openFirewall = true;
      serverConfig = {
        ServerName = "Bery's Story";
        WorldConfig = {
          AllowCreativeMode = false;
          WorldName = "Bery's World";
        };
      };

      # nix store prefetch-file --json "URL" | jq -r .hash
      mods = [

        # Brutal Hardcore Mode ========================================

        {
          filename = "135049/berys-belt-crafting-v1.0.1.zip";
          hash = "sha256-vxZoFgan3oHTB1tQ8yz9bQ3y+gJtzzHlSow91utRmQI=";
        }
        {
          filename = "92492/CartwrightsCaravan_1.9.1.zip";
          hash = "sha256-6YsgTKTO7LQVVccYk2QYSgYSDVoPZpOk2+q86g7MUJM=";
        }

        ## Backpack ===================================================

        {
          filename = "116855/ImmersiveBackpacks_1.3.4.zip";
          hash = "sha256-NNaP6hvRN+QnRJpsWR8sTyjmEuLJFti/p/CWSUCGIeo=";
        }
        {
          filename = "119566/immersivemodularbackpacks_1.7.10.zip";
          hash = "sha256-coCFrJNokArO8EKAry9eE0Nc5n2WIwcQ44S2QhOA4Gs=";
        }
        {
          filename = "134582/backpackfixes_1.0.12.zip";
          hash = "sha256-hCZvL4l52mUAnG479HNWcmbQBP/QVCOW/kG0h0ggQ2M=";
        }
        {
          filename = "92492/CartwrightsCaravan_1.9.1.zip";
          hash = "sha256-6YsgTKTO7LQVVccYk2QYSgYSDVoPZpOk2+q86g7MUJM=";
        }
        {
          filename = "107305/immersive-inventory-slots-net10-1.0.2.zip";
          hash = "sha256-rpBeBXWS82wFVYhptw1J5NfaepTTpSUPXRYUCgzjLts=";
        }
        {
          filename = "126092/ToolBelt_0.3.6.zip";
          hash = "sha256-B5jyObIjHQWm9XXRfS6xTi3I6mvhTPh7fkRHEgDVeEw=";
        }
        {
          filename = "131510/Wilderlands+Onus+Moderatus+2.0.5.zip";
          hash = "sha256-wGDNndRRjGGd+hVEgoVVfUTQ5DqR+41f4NzXMdmDu98=";
        }

        # Combat / Death ==============================================
        {
          filename = "132811/armoryfork_1.11.4.zip";
          hash = "sha256-aUp9ubCEK3H7KrPTrrooZGTzndtINUcuH+dN9b0I1s8=";
        }
        {
          filename = "128751/combatoverhaulfork_0.18.9.zip";
          hash = "sha256-BRiXdPkIedZn4nqFWq7MMFgv128FznWsgPhI/P2Wuh4=";
        }
        {
          filename = "89664/cooperativecombatrework-1.22.zip";
          hash = "sha256-bh/FwddUosGNbPSyYskrPh8aKZwr0v0PrKxSuS0MQJ4=";
        }
        {
          filename = "111730/crossbowsfork_1.10.1.zip";
          hash = "sha256-FxIUiYBEgW14MOeZVagggPtG4ihDG7pAPs82SGk5akU=";
        }
        {
          filename = "111027/morebolts-1.0.2.zip";
          hash = "sha256-GFjtrVnB3dsbz7tr6OYjkuZxpFrptosOkNw6oBbGA2c=";
        }
        {
          filename = "134511/downed_2.8.2.zip";
          hash = "sha256-HG9pODxo4JAg/7Hhy0i/PhIsWsEKTANIBLpfdjwDa9Q=";
        }
        {
          filename = "134510/dead_2.9.2.zip";
          hash = "sha256-dlyjO3bBUKNVEKnnLh/kzDOKFyopV3WHL9MHoRXcZZk=";
        }
        {
          filename = "101342/bedspawnv2_1.7.1.zip";
          hash = "sha256-Hhdo62C17xBYIgF1R6Ivnx2sr1HOz8+7h0R6zRgaWe8=";
        }
        {
          filename = "113715/multibedspawn_0.1.0.zip";
          hash = "sha256-T6n01T181clNyUz9iMdJsh+CpYer+vmr6kr9PQLyYDs=";
        }
        {
          filename = "121975/extrafirearms_1.1.5.zip";
          hash = "sha256-nyMl9f3b4EaDUB6OziSaBzhgsWyM0xaXP0BGGaX1fZg=";
        }
        {
          filename = "116538/firearmsfork_1.10.2.zip";
          hash = "sha256-ZpvUYsvwxkdyRgG+M3GySQXFC8V7nRn6+tfAgoiPaww=";
        }
        {
          filename = "52138/fleeexhaustion_1.2.0.zip";
          hash = "sha256-hIJSM64n+O3Pi7dXVMzst4gi/WqLfR7LNLBkOZf9H+c=";
        }
        {
          filename = "89910/morearrowsfork_1.2.3.zip";
          hash = "sha256-ACOs8fKKut4zCcEmnoxVSm6DuZAtPdzDM48lztcj6RM=";
        }

        # Performance =================================================
        {
          filename = "91856/anvilperformanceoptimization_1.0.0.zip";
          hash = "sha256-du6LDcHDtGJELeAsb0b6fZ5dFHcdyP7nBg4mf3TZs3Y=";
        }
        {
          filename = "132967/lodestone_1.1.1.zip";
          hash = "sha256-1+hPd0bTSmSNKlvCcCizKyx2HM5ZOoG52PBhA3dPSrI=";
        }
        {
          filename = "111597/Tungsten-1.3.7.zip";
          hash = "sha256-/UeeMnVV5BBS2jRSno6Tqx8jv2ad8QXEMkwwNZlC/9I=";
        }
        {
          filename = "111617/Synergy-1.1.25.zip";
          hash = "sha256-ooC7tWBAQ4elsmEUxwBgXXS9vGC82dP/7E+fpI0FXh8=";
        }

        # Prospecting =================================================

        # QoL =========================================================
        {
          filename = "122478/openhand_1.1.2.zip";
          hash = "sha256-idYr3PObigA9yxgHHO0s+OFJSSlAL0PK4wgCT0dtntg=";
        }

        # Systems / Mechanics =========================================

        # World Gen / Environment =====================================

        # Misc ========================================================

        {
          filename = "127110/NoticeBoard_3.0.4.zip";
          hash = "sha256-kTmv1Q/B9xrW3HrYcfGPmlGj4qotTMIfDQ+ABJYHgvE=";
        }

        # Dependencies / Compats ======================================

        {
          filename = "112834/AttributeRenderingLibrary-v3.2.0.zip";
          hash = "sha256-lmXLjh5sj1RhaGFUMacEcizaSo8BYHCGngk+ISjMcao=";
        }
        {
          filename = "99543/vsimgui_1.2.7.zip";
          hash = "sha256-J8uH3gIDSpfRVOogUmh6osAVhwvR7Qu3oBuBP6V1WOM=";
        }
        {
          filename = "115496/jsonpatcheslib_1.5.9.zip";
          hash = "sha256-tkRNOsUZuEZqfA85epwSzuvZxS4c5DwbD0mT53VEKpQ=";
        }
        {
          filename = "128748/overhaulliblegacycompat_1.2.15.zip";
          hash = "sha256-2c/aQaME98jQmskBWaJ8Kb7Sk0GT/rIsXa36TuU4bec=";
        }
      ];
    };
  };
}
