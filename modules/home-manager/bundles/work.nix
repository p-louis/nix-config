{
  pkgs,
    config,
    lib,
    ...
}: {
    myHomeManager.neomutt.enable = lib.mkDefault true;
    myHomeManager.notmuch.enable = lib.mkDefault true;
    myHomeManager.afew.enable = lib.mkDefault true;
    myHomeManager.zk.enable = lib.mkDefault true;
}
