let

  # to find an extension id, grab its slug (can be found in the url of the addon page)
  # https://addons.mozilla.org/en-US/firefox/addon/<SLUG>
  #
  # i.e, for ublock:
  # https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
  #
  # then use the API url
  # https://addons.mozilla.org/api/v5/addons/addon/<SLUG>/
  # and search for the `guid` in the json response

  mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

  mkExtensionEntry =
    {
      id,
      pinned ? false,
    }:
    let
      base = {
        install_url = mkPluginUrl id;
        installation_mode = "force_installed";
      };
    in
    if pinned then base // { default_area = "navbar"; } else base;

  mkExtensionSettings = builtins.mapAttrs (
    _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
  );
in

mkExtensionSettings {
  "78272b6fa58f4a1abaac99321d503a20@proton.me" = mkExtensionEntry {
    id = "proton-pass";
    pinned = true;
  };
  "wappalyzer@crunchlabz.com" = mkExtensionEntry {
    id = "wappalyzer";
    pinned = true;
  };

  "uBlock0@raymondhill.net" = "ublock-origin";
  "jid1-MnnxcxisBPnSXQ@jetpack" = "privacy-badger17";
  "sponsorBlocker@ajay.app" = "sponsorblock";
  "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
  "dfyoutube@example.com" = "df-youtube";
  "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = "hide-youtube-shorts";
  "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
}
