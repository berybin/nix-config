{

  flake.modules.nixos.nucbox = { lib, config, ... }: {
    networking = {
      firewall = {
        allowedTCPPorts = [ config.berynet.vintagestory.voicechatPort ];
        allowedUDPPorts = [ config.berynet.vintagestory.voicechatPort ];
      };
    };

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

        # BRUTAL HARDCORE MODE ========================================

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
        ## END Backpack ===============================================

        # COMBAT / DEATH ==============================================
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

        # PERFORMANCE =================================================
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

        # PROSPECTING =================================================
        {
          filename = "127840/bettererprospecting_3.4.12.zip";
          hash = "sha256-IPafpnC/ayGgwzM3DCdsmnxLUnDLsNPHKfbbUyRsPzo=";
        }
        {
          filename = "91913/easyprospect_1.3.1.zip";
          hash = "sha256-Xsb0V8jZGweL+ygLrjENnUTmLZ2ES56eBWKGg4R28Tc=";
        }
        {
          filename = "86405/ProspectTogether-2.2.1.zip";
          hash = "sha256-1spaOxmNNjX2op+OAAMYf6h8vuT79x0/CshZUIOSRTg=";
        }

        # QOL =========================================================
        {
          filename = "114621/betterinsulation_0.3.0.zip";
          hash = "sha256-tNblfZKWjZcS2/9c+pnHDXSk2YUOifRqhnGFLbK/qM0=";
        }
        {
          filename = "130705/BloodTrail-v1.2.12.zip";
          hash = "sha256-Js+VEnmwJPdp7GxdR2j1mHfhBL04b8TjK3Ni+kSUbkM=";
        }
        {
          filename = "129738/candela_1.0.1.zip";
          hash = "sha256-GcAFvvHGWo774sc5u+4xAzb8et2s03D8dy1agEySKM8=";
        }

        ## Chisel =====================================================
        {
          filename = "127670/ChiselTools1.17.9.zip";
          hash = "sha256-jV1Atm8zL1wdFNho/OZ73192qVqapRhfg4nCNTnZD+E=";
        }
        {
          filename = "116213/chiseledgroundplacement_0.2.2.zip";
          hash = "sha256-XwUdsQpDrYXv2PhrgAVzYUa7tC4rRCccrKUfOLfCQdE=";
        }
        {
          filename = "114866/chiseledwallmounting_0.3.2.zip";
          hash = "sha256-ORG89v7nEW5EoIT6lXGI+d4lihwBljBBVbnj/LAKv60=";
        }
        ## END Chisel =================================================
        {
          filename = "133671/crucibulum_1.8.0.zip";
          hash = "sha256-xCl/m3HDVS4m0sI/0QCi0TauITbvmlcxhtgsZ6dCavc=";
        }
        {
          filename = "87040/CureFirewood_1.0.1.zip";
          hash = "sha256-VOr3fUIVPcfLALULHMSK2IOF1kwOW0ZMiCiGm+rc5KI=";
        }
        {
          filename = "116217/densegroundstorage_0.3.3.zip";
          hash = "sha256-E4yUt6EkXynyJrlbNIaoUXnwMqpNp2e3Wrl/GL4iPjg=";
        }
        {
          filename = "86676/fixperishrate_1.0.1.zip";
          hash = "sha256-kHlRo7V3xDYliyiEcUeH+MrVPXDnYoDVOQuNbe1+vs0=";
        }
        {
          filename = "73777/forestpreserve.zip";
          hash = "sha256-BMJ4aR7RmGAXpXuhUdcplfv378aJmVj2+OD54t5HMSw=";
        }
        {
          filename = "121500/gridforbeams-2.2.196.zip";
          hash = "sha256-OlwPrVyZo0JKC4I/bK7xK0NjmqwqybzwWwSXmIesiN0=";
        }
        {
          filename = "133328/vscngroundworks_1.0.2.zip";
          hash = "sha256-FJkgpNa6hZjAUiWK9Y+FwTqz+4DlwC7BqUfUeNPPPzg=";
        }
        {
          filename = "131980/hottersmelting_1.1.6.zip";
          hash = "sha256-2ms7KEIKO9R6hYowKIBKe0WtSLg/mNJ5bmnWwztbAQQ=";
        }
        {
          filename = "125630/leanable_1.0.7.zip";
          hash = "sha256-7weKNQF2tsWBkciuyKxHzjoXVmy/W5VetgQNQTuzk7s=";
        }
        {
          filename = "118217/Molds_v0.3.7.zip";
          hash = "sha256-2GzztNnjvNsOH/Nhc1tPuQ8IL+Qcys/OnLl4PhANa68=";
        }
        {
          filename = "117393/MoreRockDrops_2x.zip";
          hash = "sha256-+kgEKbnIo35H64zzkyweyX1EHXS4snJaF8VjebWNCSY=";
        }
        {
          filename = "115330/nooffhandhungerpenalty_1.0.0.zip";
          hash = "sha256-cUdOJbkvOQVa/Dw67roSjET4H3wJ4SvVdoJgPlMugZs=";
        }
        {
          filename = "122478/openhand_1.1.2.zip";
          hash = "sha256-idYr3PObigA9yxgHHO0s+OFJSSlAL0PK4wgCT0dtntg=";
        }
        {
          filename = "129636/QuicklimeInKilnv1.1.3.zip";
          hash = "sha256-IEwegWdWu0FuCkzm8jS1iZucu3IYuhw8TI0AwrmP+zY=";
        }

        ## Salty's ====================================================
        {
          filename = "87199/CatchLedge_0.7.1.zip";
          hash = "sha256-j3zuh4KczwSeQXX9ySK885eBquKVbpCePK2NKDqgSYU=";
        }
        {
          filename = "88173/Catch+Livestock_0.2.4.zip";
          hash = "sha256-VEOzIHmB3l8FAsIM4+PzWLxY5p6iQaYVF9DXukBrOP0=";
        }
        {
          filename = "86508/ClickToPick_2.1.4.zip";
          hash = "sha256-dokiV1/174UPmHSvwN+V1bJE9KJaF7tA7kqRsalisE4=";
        }
        {
          filename = "25517/ClickUpTorches.zip";
          hash = "sha256-PMqL8RphOkiRhJLpjfrxfh2qlpDVP+2LMpVHdg9U3SE=";
        }
        {
          filename = "105870/ImmersiveLanterns_0.4.1.zip";
          hash = "sha256-V4u8izSbEbHos/bRPg3DgAUkJePvCy5sCTWDniQ0Dwo=";
        }
        {
          filename = "93488/ImmersiveFoliage_0.1.1.zip";
          hash = "sha256-4PL7Hb3iKNgi9U9O0LTcV4kQgI2s+MP7JqUZLluC/gQ=";
        }
        {
          filename = "95050/CrawlAndDive_0.2.5.zip";
          hash = "sha256-5tW8KkuKZZM8Jh4aIyFyPXO6aRu/7PmdupQU+CL/YUk=";
        }
        {
          filename = "114141/TerraTag_0.6.0.zip";
          hash = "sha256-qg/NKVbCGw/ixGxkwbOfzVP4VWbScNTb96th8rEh43U=";
        }
        ## END Salty's ================================================
        {
          filename = "97581/stablesurface_0.0.3.zip";
          hash = "sha256-NGRdOtJdsHZo0HTILzkiCqdMkEEGbDV+0++H7Y5KZsA=";
        }
        {
          filename = "108864/UnchiselOption-v1.0.0.zip";
          hash = "sha256-lU5CrmRJ+3vnazTjuWhzQoP4X08i/tRzfTbWP0+2JkA=";
        }
        {
          filename = "128654/vsroofing_2.1.1.zip";
          hash = "sha256-jUzCbbDdInVTfJPghCyb4iCjKckgdUxaTO2Kv0mSVSE=";
        }
        {
          filename = "80112/wateringcanfill_1.0.2.zip";
          hash = "sha256-wtbKZO6aQVZCqKBLPLMEjpIynrY+QX/SJqbZbWNf7TM=";
        }

        # SYSTEMS / MECHANICS =========================================
        ## Boats ======================================================
        {
          filename = "115968/boatautopilot_1.6.4.zip";
          hash = "sha256-MjSdQHZvCLQTAMikkMpVdD7h43w844lmprcuywq+r6s=";
        }
        {
          filename = "125252/sailboatbed-1.1.0.zip";
          hash = "sha256-i3V9WtjhpX2QRQJxyTTUMTW1tU3RRulbDHRJAvfCDuI=";
        }
        {
          filename = "132645/shipwright_1.5.1.zip";
          hash = "sha256-OOQm8ZdVPicu/n5j5YUHIvEl4LWggIE1nrhBOGseFzY=";
        }
        {
          filename = "133111/BoatMechanics0.4.0.zip";
          hash = "sha256-Av2P7iI/AHKQf2P7y879wNm48w6fcR2b/Lqtk5hFsZc=";
        }
        ## END Boats ==================================================

        {
          filename = "134162/BoricAlchemy3.2.4.zip";
          hash = "sha256-Ozkpzx/p6IzaranJngfmBZ7cnSJA9bQOn0YuupFnY+Y=";
        }
        {
          filename = "117484/butchering_1.14.3.zip";
          hash = "sha256-gzKjkMQmd6tDduiBfvk+iDWz8HTpzT/lNP8yqNVQiGI=";
        }
        {
          filename = "134828/JacksButcheringAddon_1.1.4.zip";
          hash = "sha256-gC8kr/KCXFqB523nqYYCSJieflUSog0osBV2pQimtAY=";
        }
        {
          filename = "132823/butcheringfotsacompatability_1.0.10.zip";
          hash = "sha256-Vgy2HW5H9zWHK+kemINhEknlpvPkhsPOpApz5Di/oG4=";
        }
        {
          filename = "113014/CarryOn-1.22.0_v1.14.3.zip";
          hash = "sha256-dd6PTVqnbDJVCJWob4+7jIqPq20CommfeyOYPYKe+Cs=";
        }
        {
          filename = "130070/CarryOnLib-1.22.0_v1.0.0-rc.1.zip";
          hash = "sha256-iU/F9QYBLfdfiOPssbQx2USlkdJO+jsjz/wgpY/y/74=";
        }
        {
          filename = "133184/enrichedpanning_1.2.0.zip";
          hash = "sha256-4g1f9kbftb5jEIOtAlq7CCMVpJpeflACRJUnBpbO+z8=";
        }

        ## Fertiliser =================================================
        {
          filename = "126270/earthfed-1.2.1.zip";
          hash = "sha256-AQRgORBW2fWsJn/oQqCqDYBf8bi+U3ok04ctWrISRVI=";
        }
        {
          filename = "120858/justpoopit_1.5.4.zip";
          hash = "sha256-76gEkxYC14D2BKKOy9vmQJ6Bs1Ayv6Mv6582TOBkS/8=";
        }
        {
          filename = "97085/naturalfertilizer-v1.22.0-1.5.1.zip";
          hash = "sha256-Y5d2/Mt//q7ywdTAonUgRcAIS/wugrpx40UCe1fh7Js=";
        }
        ## END Fertiliser =============================================

        ## Food & Cooking =============================================
        {
          filename = "133371/ExpandedFoods_2.0.0-dev.17.zip";
          hash = "sha256-E8poo88h05UMBKXgHsBUtFnC8emeYsAfctLWuZuHknk=";
        }
        {
          filename = "129701/ACulinaryArtillery_2.0.0-dev.28.zip";
          hash = "sha256-le54mSMVMfk57abfO3agK4C2jqQxd5f7q6hRB8xhM9w=";
        }
        {
          filename = "128626/ExpandedFoods_MealsModule_1.0.0-dev.9.zip";
          hash = "sha256-ZcS9h36LYfvpn31aRt5zcjBKznUQpPvZcnv/aJMrwIQ=";
        }
        {
          filename = "128235/ExpandedFoods_ChefsTricks_1.0.0-dev.6.zip";
          hash = "sha256-kuL6EC3Yny6nBvjdNjJRCXhaDprBEJ9f0N9oj3vxQk8=";
        }
        {
          filename = "126495/foodshelves_3.1.1.zip";
          hash = "sha256-g8ETMR0QSwVWd+xbqjunDQUaSP+U8/cruGAjdJ048Yg=";
        }
        ## END Food & Cooking =========================================

        {
          filename = "128112/rpvoicechat_2.6.6.zip";
          hash = "sha256-EEs+E0yYRulWGDo6CaxrF1vVo2a8dD/72TP+Pb5huRE=";
        }

        # {
        #   filename = "";
        #   hash = "";
        # }

        # WORLD GEN / ENVIRONMENT =====================================

        # MISC ========================================================

        {
          filename = "127110/NoticeBoard_3.0.4.zip";
          hash = "sha256-kTmv1Q/B9xrW3HrYcfGPmlGj4qotTMIfDQ+ABJYHgvE=";
        }

        # DEPENDENCIES / COMPATS ======================================

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
