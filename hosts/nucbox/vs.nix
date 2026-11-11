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
        StartupCommands = "/time calendarspeedmul 0.25";

        MapSizeY = 448;
        WorldConfig = {
          AllowCreativeMode = false;
          WorldName = "Bery's World";
          MapSizeY = 448;

          WorldConfiguration = {
            # keep-sorted start
            allowUndergroundFarming = true;
            bodyTemperatureResistance = 5;
            caveIns = "on";
            classExclusiveRecipes = false;
            colorAccurateWorldmap = true;
            creatureSwimSpeed = "0.9";
            daysPerMonth = "12";
            graceTimer = "10";
            landcover = "0.4";
            landformScale = "3.0";
            lightningFires = false;
            microblockChiseling = "all";
            oceanscale = "4";
            playerHungerSpeed = "0.52";
            temporalRifts = "off";
            temporalStorms = "rare";
            upheavelCommonness = "0.0";
            # keep-sorted end
          };
        };
      };

      modConfigOverrides = {
        # keep-sorted start block=yes
        "ButcheringConfigV3.json" = {
          ClassRecipesEnabled = false;
        };
        "CarryOnConfig.json" = {
          CarryOptions.InteractSpeedMultiplier = 2.0;
        };
        "ClickToPickServer.json" = {
          RemoveSneakRequirement = false;
          RequireEmptyHand = false;
        };
        "EasyProspect.json" = {
          TakeLessDurability = true;
        };
        "HydrateOrDiedrateConfig.json" = {
          Thirst.ThirstDecayRate = 7.5;
        };
        "ImmersiveMining/ImmersiveMining.json" = {
          BlockRegenerationInterval = 300; # 5 mins
        };
        "NorthernOres.json" = {
          MaximumIncreasePercent = 175.0;
        };
        "RealSmoke.json" = {
          MaxSmokeEntities = 2600;
        };
        "Toolsmith.json" = {
          HeadDurabilityMult = 8.0;
          SharpnessMult = 1.7; # default 1.5
        };
        "WandererBindleConfig.json" = {
          bindleSlots = 4;
        };
        "combatoverhaul.yaml" = {
          bows_damage_multiplier = 1.3;
          bows_reload_speed_multiplier = 0.8;
        };
        "curefirewood.yaml" = {
          "I understand and accept the risks." = true;
          "Days to cure firewood" = 12;
          "Burn duration of aged firewood" = 40;
        };
        "deciduoustrees.json" = {
          EcoMachinaBushes = false;
          KeepLeavesTrees = [
            "acacia"
            "baldcypress"
            "bamboo"
            "ebony"
            "cypress"
            "mediterraneancypress"
            "kapok"
            "pine"
            "purpleheart"
            "redwood"
            "cedar"
            "redcedar"
            "fir"
            "spruce"
            "bluespruce"
            "douglasfir"
            "tuja"
            "yew"
            "eucalyptus"
            "ghostgum"
            "tamanu"
            "kauri"
            "spurgetree"
            "guajacum"
            "ohia"
            "azobe"
            "satinash"
            "sal"
            "saxaul"
            "heather"
            "leucadendronargenteum"
            "pterocelastrustricuspidatus"
            "searsialancea"
            "afrocarpusfalcatus"
            "ocoteabullata"
            "comarostaphylisarbutoides"
            "eucalyptuscamaldulensis"
            "corymbiaaparrerinja"
            "enteleaarborescens"
            "dacrydiumcupressinum"
            "nothofagusmenziesii"
            "podocarpusnivalis"
            "halocarpusbidwillii"
            "abieskoreana"
            "phyllostachysnigra"
            "phyllostachysedulis"
            "phyllostachysaurea"
            "psuedopanaxcrassifolius"
            "laurusnobilis"
            "taxusbaccata"
            "quercusilex"
            "araucariaheterophylla"
            "pinussibirica"
            "piceaglauca"
            "piceamariana"
            "abiesbalsamea"
            "ulexeuropaeus"
          ];
        };
        "realsmokehouse.json" = {
          SmokeThreshold = 3.0;
        };
        # keep-sorted end
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
        # {
        #   filename = "107305/immersive-inventory-slots-net10-1.0.2.zip";
        #   hash = "sha256-rpBeBXWS82wFVYhptw1J5NfaepTTpSUPXRYUCgzjLts=";
        # }
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
          filename = "87717/farseer_1.4.0.zip";
          hash = "sha256-uskWdGtXwhTjHQ2RicT3vIvhG2icI46n1svzLevDArw=";
        }
        {
          filename = "94588/algernonsterrainsampler_1.3.0.zip";
          hash = "sha256-NRnHkROAgEHcsi/Q/jOMk/a2aWmcyPRWVGoMEYci47Q=";
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
          filename = "103897/desirepaths_0.5.1.zip";
          hash = "sha256-yXGg4DF3EBW7EFYrKL9HrocLJvblK0wj0LN2HFHkVGk=";
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
          filename = "136926/forestpreservefork.zip";
          hash = "sha256-72CUvhkUFGMQfkopoBDPF39V9SeHwq78BnxmSz08RTw=";
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
        {
          filename = "119690/CM-SlabbityDoDad_1.0.0.zip";
          hash = "sha256-0BR/6D/sPZUWfLmBn3e9Oxcm8hLRGkA9KzFpNMf+Lo4=";
        }
        {
          filename = "81763/sortablestorage_3.0.0.zip";
          hash = "sha256-k0z9TjhtQnzBzPF5NSWGeGVylYv7IL+3LIfu6PcVoZA=";
        }

        ## Salty's ====================================================
        {
          filename = "87199/CatchLedge_0.7.1.zip";
          hash = "sha256-j3zuh4KczwSeQXX9ySK885eBquKVbpCePK2NKDqgSYU=";
        }
        # {
        #   filename = "86508/ClickToPick_2.1.4.zip";
        #   hash = "sha256-dokiV1/174UPmHSvwN+V1bJE9KJaF7tA7kqRsalisE4=";
        # }
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
          filename = "136884/BoricAlchemy3.2.8.zip";
          hash = "sha256-ufsWmasziGsjbmaG4zpv5br8OSGmqfDD79KiL2n1Rzs=";
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
          filename = "137914/butcheringfotsacompatability_1.0.11.zip";
          hash = "sha256-+jbpV+b+qPHNdUzQoI3nmmqB+3S0xpXKGR0KaHlYxUs=";
        }
        {
          filename = "130071/CarryOn-1.22.0_v2.0.0-rc.1.zip";
          hash = "sha256-e90Z8UH95PftZYjKwF1RotLV1W7WGMukYfdqTd5CvoA=";
        }
        {
          filename = "130070/CarryOnLib-1.22.0_v1.0.0-rc.1.zip";
          hash = "sha256-iU/F9QYBLfdfiOPssbQx2USlkdJO+jsjz/wgpY/y/74=";
        }
        {
          filename = "137650/cottageindustry_1.1.0.zip";
          hash = "sha256-jUyppVfn+VwYLhNTurM0QqFE03EbXBOJi3KzpqZ4UpU=";
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
          filename = "97085/naturalfertilizer-v1.22.0-1.5.1.zip";
          hash = "sha256-Y5d2/Mt//q7ywdTAonUgRcAIS/wugrpx40UCe1fh7Js=";
        }
        {
          # piss mod
          filename = "126041/naturescall_1.4.2.zip";
          hash = "sha256-rRdCGoYQmc55/mvzEbqiTl2udbOEVpxmU50IDXX8yD8=";
        }
        {
          filename = "120858/justpoopit_1.5.4.zip";
          hash = "sha256-76gEkxYC14D2BKKOy9vmQJ6Bs1Ayv6Mv6582TOBkS/8=";
        }
        ## END Fertiliser =============================================

        ## Food & Cooking =============================================
        {
          filename = "133371/ExpandedFoods_2.0.0-dev.17.zip";
          hash = "sha256-E8poo88h05UMBKXgHsBUtFnC8emeYsAfctLWuZuHknk=";
        }
        {
          filename = "137261/ACulinaryArtillery_2.0.0-dev.29.zip";
          hash = "sha256-km9OlL6lPu4V4PYLiHO8mp/QlsMmz/byC2jhvasi9xQ=";
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
          filename = "130914/fornax_1.10.0.zip";
          hash = "sha256-uY4plKbiZ8vIswYEVsL0vjapqKcR+yYMxuj2EnN5qLE=";
        }
        ## Map
        {
          filename = "133538/frontiers-map-net10_2.0.2.zip";
          hash = "sha256-sj8PNm1WjJppWyrWkMGUCJdxvgKjxrLyL/8K7RnUWtI=";
        }
        {
          filename = "133532/nomads-flute-net10_1.0.2.zip";
          hash = "sha256-wz/KhOpczpEL3o3djzrDdPUtWeUxkklKoJ2l94b28W4=";
        }
        ## END Map
        {
          filename = "128386/hydrateordiedrate_2.5.8.zip";
          hash = "sha256-1lPfyNer6Mt2JGoNBVQoaXBLzOywvmF9/DfqwRnzyo8=";
        }
        {
          filename = "123715/millwright_1.3.5.zip";
          hash = "sha256-7Aj+6e9y2QRuvxoQPwbPXLxBbIjpl0C27qkGbBTPEbQ=";
        }
        {
          filename = "117063/plentifultreefelling_v1.2.0.zip";
          hash = "sha256-zksTEsIeXilVEAKv9OCZD2gDKYVl9xmMq4M3cLVmR7k=";
        }
        {
          filename = "123599/primitivesurvival_5.1.4.zip";
          hash = "sha256-mhB7EH2toPEuQjUzIixlQYdPtkbQ4mP3XCEeN6KPo3k=";
        }
        {
          filename = "134375/realsmoke_2.0.0-pre.12.zip";
          hash = "sha256-GWWHdpzwLYGc8WWRzVA6brC7kXTNX26oMEna+60SqL8=";
        }
        {
          filename = "129965/RealSmokehouse_0.6.1.zip";
          hash = "sha256-Uvvtis7Qkqhu7TfExzLXbo/7nb7KpLQMFDHsDybAXok=";
        }
        {
          filename = "99801/RealSmokeQPPatch1.0.1.zip";
          hash = "sha256-0gQTKVrb2FuROuQeeLZ9zbiO87Cgckjv5yshxonOLKg=";
        }
        {
          filename = "128600/realisticwater_0.4.0.zip";
          hash = "sha256-K2Yg2+0ofxvMyMWym1GIekz2rCz2HfvagMIwzDRuoSU=";
        }
        {
          filename = "128601/realisticrapids_0.1.3.zip";
          hash = "sha256-cB1NXXlNdF3SQ5mcmWmzMhs7lLvee3lSwbFpcNtB3Sw=";
        }
        {
          filename = "128112/rpvoicechat_2.6.6.zip";
          hash = "sha256-EEs+E0yYRulWGDo6CaxrF1vVo2a8dD/72TP+Pb5huRE=";
        }
        {
          filename = "102793/ImmersiveMining_0.3.0.zip";
          hash = "sha256-5V2JkppseLsprNiGUv6NUSXvSuBBNCOKqarM+uW2Fkg=";
        }
        {
          filename = "130556/smithingplusplus_1.10.7.zip";
          hash = "sha256-1Fw6+zhxmwKW/eklfBq6tkk20SK2WyUkxilhSArPyxQ=";
        }
        {
          filename = "134617/pistolbarrelnocast_1.0.3.zip";
          hash = "sha256-fcEOzsSSQARpeqb6B7AphUFGhWVZ4LXpct8bj2BD/kQ=";
        }
        {
          filename = "114848/toolsmith_1.2.19.zip";
          hash = "sha256-Ml6tZKkZLqdCbQF+HFFBKG+GD5XDr13TS3mtFPBgl0s=";
        }
        {
          filename = "105641/Waterfall_v1.2.4.zip";
          hash = "sha256-W6cJbu7RuXDXir5Cd2jMDxOC7YtBGanXSMt9P/VQbF4=";
        }
        {
          filename = "122689/woodaging-1.0.1.zip";
          hash = "sha256-mx5HyEj4do4ax58Fn9c4NKk/jQgCcP+GKQod36Rjkqk=";
        }
        {
          filename = "137668/xSkills+Fork+v1.1.16.zip";
          hash = "sha256-xsndewXi+CLOpruJjeasAu+SQT8W3Js1Nkec1isy1C4=";
        }
        {
          filename = "135564/XLib+Fork+v1.0.44.zip";
          hash = "sha256-ShGCXCtZNbHhrOXQRkOSU9uKLfl6upk5N+tCLS9+Hgw=";
        }

        # WORLD GEN / ENVIRONMENT =====================================
        {
          filename = "132812/watersheds_7.0.6.zip";
          hash = "sha256-Pk0zny2H3y3trcidXOBow7gRp4rO/zyTE+bFMsTw2GU=";
        }
        {
          filename = "109742/th3dungeon_v1.0.2.zip";
          hash = "sha256-eNjLg6SOE5G++v7hTCgvCnaEIkh8NjLBaZ0baYcgeUA=";
        }
        {
          filename = "135601/deciduoustrees_2.1.1.zip";
          hash = "sha256-PDthf49zHsvxnd0x0ieEnewjzebCGSIMVtOKwJdt4GE=";
        }

        ## Fauna of the Stone Age =====================================
        {
          filename = "137570/FotSA-Bovinae-v1.0.2.zip";
          hash = "sha256-vXYNyidOx14MRAQv8cL4aa+JrySVUyZtQOyJiXCgwMw=";
        }
        {
          filename = "126789/FotSA-Caninae-v1.1.10.zip";
          hash = "sha256-mIkFcXga+r6ry7QQ0FtXkigOuGcNSSAROekUErhsOEI=";
        }
        {
          filename = "136198/FotSA-Capreolinae-v2.0.21.zip";
          hash = "sha256-uq6Pd1XqkqnmBhgR8i6rnu5/bp42KUoY6UzPTFjLGfM=";
        }
        {
          filename = "137571/FotSA-Cervinae-v0.1.19.zip";
          hash = "sha256-JE2pb730Hsh9JEgBnFO/EeJzeymoHH6YwgEIaRnHFnw=";
        }
        {
          filename = "130132/FotSA-Chelonioidea-v1.0.10.zip";
          hash = "sha256-tUSyckP1pLaVZ0C97+aOG3JkHzxa8dcp2ON6G/Jd+Ds=";
        }
        {
          filename = "136202/FotSA-Elephantidae-v1.0.23.zip";
          hash = "sha256-+NUMAtciZg9XIgIEMJq6ATEDZHvp5Ms+wj5mMT7apcg=";
        }
        {
          filename = "130127/FotSA-Felinae-v0.2.16.zip";
          hash = "sha256-e9NHpx61mc8XtD51QCyp/X0pDDChOclHdn5zsw+6cKM=";
        }
        {
          filename = "128572/FotSA-Iniidae-v0.1.8.zip";
          hash = "sha256-2PoYvyxuh0TpCT8SKJs9AKvedg4BjQToToHYKjWFYvw=";
        }
        {
          filename = "124638/FotSA-Machairodontinae-v1.1.13.zip";
          hash = "sha256-1qsQ/LF7j9tF/IBVSFnMnmV499g2F4PrsKn1AB2Cpks=";
        }
        {
          filename = "130124/FotSA-Manidae-v1.0.24.zip";
          hash = "sha256-x+0xAoOoMPvgP411DQ6kJY6d8u5e/yhYzyZyzVr1zqI=";
        }
        {
          filename = "130129/FotSA-Meiolaniidae-v0.1.13.zip";
          hash = "sha256-VUxmWSZqOXeYEykPt86q3v8/jcjlkNifMfRAqgMHBYI=";
        }
        {
          filename = "136203/FotSA-Moschidae-v1.0.1.zip";
          hash = "sha256-P7cqPuHjQ0v9wyhu1VUnLcj9zLLR9Y5IoCvjglUxyE8=";
        }
        {
          filename = "121535/FotSA-Pantherinae-v1.2.18.zip";
          hash = "sha256-Bf7YVMUOnmmsaC/JNzF664YJ4LUUtAmPdEaJHG4EAsE=";
        }
        {
          filename = "130123/FotSA-Rhinocerotidae-v1.0.29.zip";
          hash = "sha256-dXxznaEwmF/ZwanUzzIF85LA58qcOvUEI/2i7pQjDcw=";
        }
        {
          filename = "126790/FotSA-Sirenia-v1.0.33.zip";
          hash = "sha256-hMQnyxQ41qknCJzWnLuEqG/JqWJeUiOo2ObCyxl0pVE=";
        }
        {
          filename = "136207/FotSA-Thylacinidae-v0.1.9.zip";
          hash = "sha256-JjyKuAj7vNKz1p+pV2H4pKdUpXL+vz5lSQZMd84E0do=";
        }
        {
          filename = "130130/FotSA-Viverridae-v1.0.11.zip";
          hash = "sha256-tQcUTQfeyWXjh5eTRc0ACj7C+QPlPLmmT44Angta0wM=";
        }
        {
          filename = "129720/FotSA-Vombatidae-v0.4.8.zip";
          hash = "sha256-VHmxa2Ij5yuvnE+NLIGMKw1l8FGVahe+DSVM3tZxIVY=";
        }
        ## END Fauna of the Stone Age =================================

        ## Floral Zones =============================================
        {
          filename = "137558/FloralZonesCapeRegion-v1.0.39.zip";
          hash = "sha256-JvEn1AP459jEyjz+pXBR25WczwDrVXQm8QnEAehcP7Q=";
        }
        {
          filename = "137559/FloralZonesCaribbeanRegion-v1.0.31.zip";
          hash = "sha256-SI4OQAACFinXGJ61yEUpCGlZHbeMuCw8MLuIx8EcEI4=";
        }
        {
          filename = "137560/FloralZonesCentralAustralianRegion-v1.0.29.zip";
          hash = "sha256-8jztCBZvUTD1Ktu/sv2sewXeK0ABn/WfLOsUTtketLA=";
        }
        {
          filename = "137565/FloralZonesCircumborealRegion-v1.0.5.zip";
          hash = "sha256-hICF1jyTmzt6R/Xt9hupYCq4U2yDoko/w/vmaq7NfaM=";
        }
        {
          filename = "137564/FloralZonesCosmopolitanRegion-v1.0.15.zip";
          hash = "sha256-w/y2iNJ2P37fV+lqU4lXGIJEy1V/foysuoRIJoK9kDI=";
        }
        {
          filename = "137561/FloralZonesEastAsiaticRegion-v1.0.26.zip";
          hash = "sha256-2FbdJPWxirdgg5BUnne41si8hpvCD7Y9FBY/UfpiOqs=";
        }
        {
          filename = "137562/FloralZonesNeozeylandicRegion-v1.0.27.zip";
          hash = "sha256-VdzJdUJGHxprzRj+hd2M4S3Xh5Pgw1IlrVdmdWil/I4=";
        }
        {
          filename = "137563/FloralZonesMediterraneanRegion-v1.0.26.zip";
          hash = "sha256-FtSk1oR+OFuZt1veJxKzHd1Yvf4Hm7yr5aqGjQJ0+ME=";
        }
        {
          filename = "110267/FloralZones-xSkillsFork-Compat-v1.0.0.zip";
          hash = "sha256-pyiCc7gt7SYfWjP41zSrLOw61DD0mU34QNKH6J3IyOw=";
        }
        {
          filename = "110265/FloralZonesExpandedFoodsCompat_v1_2_1_FullFlourKitchen_NoCrash.zip";
          hash = "sha256-WfP1GG/lprQNsXyIc8LlfcSNkxjdJOUyabjp43qo5uw=";
        }
        {
          filename = "110822/FloralZones122Bridge-v0.6.1-Standalone.zip";
          hash = "sha256-ycRbtlGfMBgNvn782Y/RGW1TM2PTuyUX5AJjWnU2GKU=";
        }
        {
          filename = "130844/floralzonespurposefulstoragecompat.zip";
          hash = "sha256-Mv1FPqMsxz7bVAHhYDAEe+FDr3L7ngxv+Lyj1zZIQos=";
        }
        {
          filename = "130816/floralzonesshipwrightcompat1.0.2.zip";
          hash = "sha256-r4Lbce0187/IWUAEXAuC7ev6iZhGGV5KoU2IZ7OqE1g=";
        }
        {
          filename = "130216/floralzonesfoodshelvescompat_1.0.0.zip";
          hash = "sha256-Ske483J/GN4KC/4NZqKweTPzfC9xekYjpyCQBKj0sv8=";
        }
        ## END Floral Zones =========================================
        {
          filename = "135553/leaflitter_1.4.2.zip";
          hash = "sha256-OV78EFfAbHwunAmQfGAClUPIy/VNbxuFGLmz3+5MQ1A=";
        }
        {
          filename = "132329/seasonalflowers_2.0.2.zip";
          hash = "sha256-t5m6LUy6AQdW96CM9SB9PuL6GwX53A8YD9seXeHmb7k=";
        }
        {
          filename = "113781/TerraPrety_7.11.1.zip";
          hash = "sha256-4PHXZ3ai1fGhZWlhBdBkC2of59eCjeAIKTQp05pVEn8=";
        }
        {
          filename = "105879/terrainslabs_1.0.17.zip";
          hash = "sha256-s6sCUGqbAg7/Oac9DmeMJnd8kjbVFF25c39QiPffetw=";
        }
        {
          filename = "106068/placeonslabs_1.2.0.zip";
          hash = "sha256-9lMTrV084C0tYrOP04R6+1PCdcbW8JTWqC2CFfhA2Ik=";
        }
        {
          filename = "113981/vsvillage_v6.0.5.zip";
          hash = "sha256-mmkBCSAJ86y5bMze6veo3trAD/nbaRlW0bPj8ZPuR3E=";
        }

        # MISC ========================================================
        {
          filename = "94908/adventurers-walking-stick-lite-net10_1.0.0.zip";
          hash = "sha256-42NuUSOd+qjnKG1QB25Dzb/HLm08wWOxge0KkPfgoi4=";
        }
        {
          filename = "114075/animalcages_v5.0.1.zip";
          hash = "sha256-WFXLI0IsfqTDnJW3fOI4YMFlAKocUOu5mcnohRPFGN8=";
        }
        {
          filename = "86281/HeraldryBanners-v2.0.0.zip";
          hash = "sha256-PoyapE9MevO0W4WhJh2uU4nfjkJfuq1v5GSbyvrR8nc=";
        }
        {
          filename = "86275/Heraldry-v2.0.0.zip";
          hash = "sha256-Hhd8AXF4dZCFE78jSGrVWryVfN7pGuNS92TPHDdx7YQ=";
        }
        {
          filename = "132934/BetterTradersv0.2.2.zip";
          hash = "sha256-WY7SK4CWwWx1jVe1VzQCkJzPdlOuRw3G7sEbvL5m9pE=";
        }
        {
          filename = "86695/bronzemeteoricmining_v1.3.1.zip";
          hash = "sha256-3S9yWbuGwqPV78CKIwdHRxYaHIfP5s3Nl0QNOzdlM6U=";
        }
        {
          filename = "132838/coinage-2.4.0.zip";
          hash = "sha256-cQwcg5muJNrxwnFQBAe4XZMFREtIn9JwnXhLy2yGzgM=";
        }
        {
          filename = "106695/daubweave.zip";
          hash = "sha256-rTb635aCikg5T9JfmfXNERgdsV0u9b6W0ACtYdRgQ2E=";
        }
        {
          filename = "97713/elkjaunt_1.4.0.zip";
          hash = "sha256-HNdHyCN8klCC4IvxzrXC+cyqL3zb2sRSNfu/Z2Mo19k=";
        }
        {
          filename = "123788/jaunt_3.3.1.zip";
          hash = "sha256-VMTTPlCO3nH6PqrPNP+FNj5I86Bpxntw0lDFVR9j4a8=";
        }
        {
          filename = "108451/elkvariants_3.7.2.zip";
          hash = "sha256-lwJDPGyphk3u/Cogzj0eCABVlamILlJd4pD1j0HJ48w=";
        }
        {
          filename = "87438/ElkPhysics+V3.0.3.zip";
          hash = "sha256-E5Mrp1VRUOU+Dhk5NDhn/ku/v99IR11wNBlqlX2vmOk=";
        }
        {
          filename = "112377/messengerpigeons_1.0.2.zip";
          hash = "sha256-F3G0O1jq5mjXEMFo7pshiQKnzYUOkV7hJOJa59TFy+4=";
        }
        {
          filename = "134185/morebuckets_1.4.3.zip";
          hash = "sha256-QXg/hwDT8G68d+JpvNZPoOdGg+PhbSCUgSDdb4aLrWA=";
        }
        {
          filename = "107154/NorthernOres.zip";
          hash = "sha256-1/HXzhPj0zmlZkzK/eVTnwa0IJ0Dk0KzEfEnm6teN4I=";
        }
        {
          filename = "116052/notsotastywax-1.0.2.zip";
          hash = "sha256-vMbw8Nc6ZagwH18UjvcYXkMw66hMegyzumyX3iEYnFI=";
        }
        {
          filename = "127110/NoticeBoard_3.0.4.zip";
          hash = "sha256-kTmv1Q/B9xrW3HrYcfGPmlGj4qotTMIfDQ+ABJYHgvE=";
        }
        {
          filename = "123866/oillampsanywhere_1.1.0.zip";
          hash = "sha256-xkj+8iosRU0N+BwGLb4cwJ2b+rIlDA2+AaUI2uHYyE8=";
        }
        {
          filename = "96460/pipeleaf_2.6.1.zip";
          hash = "sha256-zYZ5owDf4KjaL+gwoTmZ9/a1U9MF+7mMq5JtD2k2Ssg=";
        }
        {
          filename = "136558/portcullismod-1227.0.5.zip";
          hash = "sha256-CIWK/w2CxborYl5Ub6NXnb0bXON3fYFZB9lbRWciqVs=";
        }
        {
          filename = "135180/purposefulstorage_2.3.0.zip";
          hash = "sha256-xVdK7mweOOFeuuaKiJ4MrgXQYbCSc/8l6rVuYw1SbN0=";
        }
        {
          filename = "129808/shadehouse_1.9.0.zip";
          hash = "sha256-4tEcOKFe1GPfmB49XCfWHE6BIm5fRQWJV46llOZN6nA=";
        }
        {
          filename = "128810/thesumpter-1.2.0.zip";
          hash = "sha256-LIj3g+nJPaTHEadTUam4NuAErzui7ZOYYb/TQYPb1RE=";
        }
        {
          filename = "103050/TankardsandGoblets_v1.4.4.zip";
          hash = "sha256-laTRIyUPRbXD+sSn+6wnii+PfhaGfwKg01VhbqHEpCE=";
        }
        {
          filename = "126323/TransmittanceV1.2.0.zip";
          hash = "sha256-5e8QrI4s/1fxHy8QdyLbkTxTqtHzHV8FaA/Bonx/t8E=";
        }
        {
          filename = "136127/vintagecanvas_1.4.2.zip";
          hash = "sha256-LC20AMUaPJBRQs4p5e8/X9oNCznJeXB9A7Sfg9WrzdU=";
        }
        {
          filename = "129259/wandererbindle_1.0.1.zip";
          hash = "sha256-deJeEEhFFew0NOyzK6+WzTMMVSrW3eEye/41pDW6i/g=";
        }
        {
          filename = "57499/warmgambeson.zip";
          hash = "sha256-rhM/QUWyFjYIt+KiY/3R61CEgf596rfZnw+E9nNiLsA=";
        }
        {
          filename = "132945/warmlight_v1.0.0.zip";
          hash = "sha256-2Y+z/zNvBRGUReoEd9u4s2cN3TXDwTc7DUSpGlgctNc=";
        }
        {
          filename = "124242/Wilderlands+Waymarkers+1.0.6.zip";
          hash = "sha256-8wUgUcnLLoOE2TdHYcxtcbXViYDu+bsgjaGlKHf+Kug=";
        }
        {
          filename = "128435/windchimes-1.22.0-v1.5.4.zip";
          hash = "sha256-kwtJ1dNU7PJ3CJWzLuwo2mV7qiDWEYHxvmgKu52lABQ=";
        }
        {
          filename = "122707/woodenfortifications_2.1.0.zip";
          hash = "sha256-kM5LPTHgyDF2O32ErRR1SXkZPXQ0cfuF17lsTazsMFU=";
        }
        {
          filename = "131707/Zombs-Purposeful-Storage-Weapon-Patches-2.7.0.zip";
          hash = "sha256-f985pIoWdTr4XkT0aX3WO5ZxW3OSoMBfEOlWOf3mBKE=";
        }

        # DEPENDENCIES / COMPATS ======================================
        {
          filename = "112834/AttributeRenderingLibrary-v3.2.0.zip";
          hash = "sha256-lmXLjh5sj1RhaGFUMacEcizaSo8BYHCGngk+ISjMcao=";
        }
        {
          filename = "119253/configlib_1.13.2.zip";
          hash = "sha256-F5Q9zftbk8KDQ+GeZrWC2mkBnnhj+WRQ+GNzmfgPHJU=";
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
