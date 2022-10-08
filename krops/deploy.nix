let
  # FIXME:
  target = "root@10.10.2.1";

  extraSources = {
    "hardware-configuration.nix".file = toString ../hardware-configuration.nix;
    "modesetting.nix".file = toString ../modesetting.nix;
    "default.nix".file = toString ../default.nix;
  };

  krops = (import <nix-bitcoin> {}).krops;
in
krops.pkgs.krops.writeDeploy "deploy" {
  inherit target;

  source = import ./sources.nix { inherit extraSources krops; };

  # Avoid having to create a sentinel file.
  # Otherwise /var/src/.populate must be created on the target node to signal krops
  # that it is allowed to deploy.
  force = true;
}


