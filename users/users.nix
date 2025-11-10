{ ... }:
let
  users = [{
    username = "henrik";
    homeDirectory = "/home/henrik";
  }];
in { inherit users; }
