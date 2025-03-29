{
  pkgs ? import <nixpkgs> { },
  diskoLib ? pkgs.callPackage ../lib { },
}:
diskoLib.testLib.makeDiskoTest {
  inherit pkgs;
  name = "lvm-cache";
  disko-config = ../example/lvm-cache.nix;
  extraTestScript = ''
    machine.succeed("mountpoint /home");
  '';
  extraInstallerConfig = {
    boot.kernelModules = [
      "dm-raid"
      "dm-cache"
      # "dm-writecache" maybe make this a configurable option
      "dm-mirror"
    ];
  };
}
