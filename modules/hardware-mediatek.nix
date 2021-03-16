{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption mkMerge mkIf types;
  cfg = config.mobile.hardware.socs;
in
{
  options.mobile = {
    hardware.socs.mediatek-mt6755.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable when SOC is Mediatek MT6755 (Helio P10)";
    };
    hardware.socs.mediatek-mt6785.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable when SOC is Mediatek MT6785 (Helio G90)";
    };
    hardware.socs.mediatek-mt8167s.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable when SOC is Mediatek MT8167S";
    };
  };

  config = mkMerge [
    {
      mobile = mkIf cfg.mediatek-mt6755.enable {
        system.system = "aarch64-linux";
        quirks.fb-refresher.enable = true;
      };
    }
    {
      mobile = mkIf cfg.mediatek-mt6785.enable {
        system.system = "aarch64-linux";
      };
    }
    {
      mobile = mkIf cfg.mediatek-mt8167s.enable {
        system.system = "aarch64-linux";
      };
    }
  ];
}
