{ inputs, spaces }:
rec {
  # NOTE: essential pins
  "codeberg" = {
    id = "740bea3c-861c-4e4e-8c25-e3989bf2c620";
    workspace = spaces.personal.id;
    url = "https://codeberg.org/berybin";
    isEssential = true;
    editedTitle = true;
    position = 0;
  };
  "github" = {
    id = "526ab33d-df24-43a5-ad07-af636af4b0e6";
    workspace = spaces.personal.id;
    url = "https://github.com/berybin?tab=repositories";
    isEssential = true;
    editedTitle = true;
    position = 1;
  };
  "proton mail" = {
    id = "";
    workspace = spaces.personal.id;
    url = "https://mail.proton.me/u/3/inbox";
    isEssential = true;
    editedTitle = true;
    position = 2;
  };
  "proton calendar" = {
    id = "111464c7-4c53-4650-a50c-afd1c9e8daab";
    workspace = spaces.personal.id;
    url = "https://calendar.proton.me/u/3/";
    isEssential = true;
    editedTitle = true;
    position = 3;
  };
  "proton drive" = {
    id = "d9803272-b4d3-4203-b7fb-c47239cdb2d4";
    workspace = spaces.personal.id;
    url = "https://drive.proton.me/u/3/";
    isEssential = true;
    editedTitle = true;
    position = 4;
  };

  # NOTE: regular pins
  "youtube" = {
    id = "0de4625b-4509-440f-831d-38cf815bf4f9";
    workspace = spaces.personal.id;
    url = "https://www.youtube.com/feed/subscriptions";
    editedTitle = true;
    position = 5;
  };

  # NOTE: /nix pin group
  "nix" = {
    id = "75d80b05-c3f4-460d-8064-ea1bcc2ed05c";
    workspace = spaces.personal.id;
    editedTitle = true;
    isGroup = true;
    isFolderCollapsed = true;
    position = 100;
  };
  "nixos search" = {
    id = "a0770f40-6f7d-4bda-8374-2cf08e23d51e";
    url = "https://search.nixos.org/packages?channel=unstable&include_modular_service_options=1&include_nixos_options=1";
    folderParentId = nix.id;
    editedTitle = true;
    position = 102;
  };
  "home manager search" = {
    id = "9b1ac2cd-894f-487c-a58b-ed4ac66e2ad2";
    url = "https://home-manager-options.extranix.com/?query=&release=master";
    folderParentId = nix.id;
    editedTitle = true;
    position = 103;
  };

  "noogle" = {
    id = "d2fc2d09-942b-47c6-843b-f76bc21c3bc8";
    url = "https://noogle.dev/";
    folderParentId = nix.id;
    editedTitle = true;
    position = 104;
  };
  "nixpkgs" = {
    id = "efd5584e-c220-47f3-b727-0871e49b876d";
    url = "https://github.com/nixos/nixpkgs";
    folderParentId = nix.id;
    editedTitle = true;
    position = 105;
  };
  "snowfall" = {
    id = "ed512d29-34e2-4de9-bad2-9049ab7572c5";
    url = "https://snowfall.org/guides/lib/quickstart/";
    folderParentId = nix.id;
    editedTitle = true;
    position = 106;
  };

  # NOTE: homelab pin group
  "homelab" = {
    id = "6916e13a-a748-4793-9b91-8ee4d5edc49e";
    workspace = spaces.personal.id;
    editedTitle = true;
    isGroup = true;
    isFolderCollapsed = true;
    position = 200;
  };
  "irongiant" = {
    id = "74f74d63-9534-4880-a53c-af5d8843d1df";
    url = inputs.nix-secrets.server.irongiant.ip;
    folderParentId = homelab.id;
    editedTitle = true;
    position = 201;
  };
  "diskjockey (omv)" = {
    id = "c3f0a966-0ec6-456e-9805-5adf9a3837ce";
    url = "http://diskjockey.local";
    folderParentId = homelab.id;
    editedTitle = true;
    position = 202;
  };
  "jukebox" = {
    id = "0b88f755-28e3-494c-8958-ac06312a0d38";
    url = "http://jukebox.local:8096";
    folderParentId = homelab.id;
    editedTitle = true;
    position = 203;
  };
  "adguard" = {
    id = "935a0745-f8eb-497d-9ef0-6b1b3543030f";
    url = "http://toaster.local:3000/";
    folderParentId = homelab.id;
    editedTitle = true;
    position = 204;
  };
  "router" = {
    id = "7009b80f-9266-483e-b407-f727d17b6168";
    url = inputs.nix-secrets.server.gateway.ip;
    folderParentId = homelab.id;
    editedTitle = true;
    position = 205;
  };

  # NOTE: web pin group
  "web" = {
    id = "763dd208-b599-4298-b715-2b062b252e78";
    workspace = spaces.personal.id;
    editedTitle = true;
    isGroup = true;
    isFolderCollapsed = true;
    position = 300;
  };
  "pfych" = {
    id = "29149e7d-ab57-4265-8b9e-d058adbdbf0b";
    url = "https://pfy.ch/";
    folderParentId = web.id;
    position = 301;
  };
  "pagemelt" = {
    id = "785bfe4d-a15e-42c7-b7e2-cb697ea562f9";
    url = "https://pagemelt.zone/";
    folderParentId = web.id;
    position = 302;
  };
  "marighoul" = {
    id = "6ffe6ed1-7ce7-4cba-9299-eabdf2b7c9b2";
    url = "https://marighoul.com/";
    folderParentId = web.id;
    position = 303;
  };
  "daniele" = {
    id = "d200b46c-5e88-4b7a-add3-65ffea57e829";
    url = "https://daniele63.com/";
    folderParentId = web.id;
    position = 304;
  };
  "onio.club" = {
    id = "aea2a695-a5d5-450e-b472-0fb4f3b4db86";
    url = "https://onio.club/";
    folderParentId = web.id;
    position = 305;
  };
  "ben borgers" = {
    id = "f5020fc2-4ebf-4c46-86a3-54c47877c0de";
    url = "https://ben.page/";
    folderParentId = web.id;
    position = 306;
  };
  "maggie appleton" = {
    id = "44bcf1fe-d06b-42f6-ad81-622d80ca9318";
    url = "https://maggieappleton.com/";
    folderParentId = web.id;
    position = 307;
  };
  "ang's corner" = {
    id = "47289988-c432-4a94-aa37-4be584958744";
    url = "https://angs-corner.nekoweb.org/";
    folderParentId = web.id;
    position = 308;
  };

  # NOTE: uni pins
  "canvas" = {
    id = "3edec9da-548b-4ba2-a723-228be977087a";
    workspace = spaces.uni.id;
    url = "https://canvas.sydney.edu.au/";
    editedTitle = true;
    position = 0;
  };
  "outlook" = {
    id = "470575ea-899e-4001-9739-905cb47a75f5";
    workspace = spaces.uni.id;
    url = "https://outlook.cloud.microsoft/mail/0/";
    editedTitle = true;
    position = 1;
  };
  "ed" = {
    id = "2f8eaa07-5e7b-42ad-93db-37dc897c1215";
    workspace = spaces.uni.id;
    url = "https://edstem.org/au/dashboard";
    editedTitle = true;
    position = 2;
  };
  "echo" = {
    id = "827eb197-b4d2-4836-bf09-a70bebe15eca";
    workspace = spaces.uni.id;
    url = "https://login.echo360.net.au/login";
    editedTitle = true;
    position = 3;
  };

  # NOTE: /admin uni pins
  "admin" = {
    id = "2db1838b-3a78-4d8a-b851-01fff6b6430c";
    workspace = spaces.uni.id;
    editedTitle = true;
    isGroup = true;
    isFolderCollapsed = true;
    position = 100;
  };
  "student portal" = {
    id = "81b8830e-4f9c-497f-af4b-a297e79adbe2";
    url = "https://myuni.sydney.edu.au/";
    folderParentId = admin.id;
    editedTitle = true;
    position = 101;
  };
  "sydney student" = {
    id = "41c18384-f243-46fc-a270-7a7ea9e2d81f";
    folderParentId = admin.id;
    url = "https://sydneystudent.sydney.edu.au/";
    editedTitle = true;
    position = 102;
  };
  "allocate (timetable)" = {
    id = "e5fd5f98-6057-4f81-b3fb-9928ea02913b";
    folderParentId = admin.id;
    url = "https://timetable.sydney.edu.au/even/";
    editedTitle = true;
    position = 103;
  };
  "zoom" = {
    id = "c0c18f09-383a-4a43-b77d-7d94ecacad08";
    folderParentId = admin.id;
    url = "https://uni-sydney.zoom.us/profile";
    editedTitle = true;
    position = 104;
  };
}
