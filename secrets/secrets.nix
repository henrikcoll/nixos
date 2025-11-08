let
  YK29644816 = "age1yubikey1qwaw84vwajylqwswhxpnm8vy7hp60uwf835gtg490ax3t504mnrsckv4532";
  yubikeys = [ YK29644816 ];
  titan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7v98S3MY7JN0hiFvkU7NcEfHY4lAYJGxCgRSUoaLSM";
  systems = [ titan ];
in
{
  "titan/syncthing/cert.pem.age".publicKeys = [ titan ] ++ yubikeys;
  "titan/syncthing/key.pem.age".publicKeys = [ titan ] ++ yubikeys;
}
