let
  mkEssentialAttrs =
    attrs:
    builtins.mapAttrs (
      _: value:
      value
      // {
        isEssential = true;
        editedTitle = true;
      }
    ) attrs;
in

mkEssentialAttrs {

  "Codeberg | berybin" = {
    id = "888e503d-2d8f-43aa-867f-ccc97ef6371a";
    url = "https://codeberg.org/berybin";
    position = 100;
  };

  "GitHub | berybin" = {
    id = "48474168-8d67-4751-8ba7-ef36c9aa928f";
    url = "https://github.com/berybin?tab=repositories";
    position = 200;
  };

  "Proton Mail" = {
    id = "7d470e24-3f02-4270-bd6f-72a4ba0bf5c6";
    url = "https://mail.proton.me";
    position = 300;
  };
}
