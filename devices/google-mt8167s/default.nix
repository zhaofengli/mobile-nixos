{ config, lib, pkgs, ... }:

{
  mobile.device.name = "google-mt8167s";
  mobile.device.identity = {
    name = "Android Things MT8167S";
    manufacturer = "Google";
  };

  mobile.hardware = {
    soc = "mediatek-mt8167s";
    ram = 1024;
    screen = {
      width = 480; height = 800;
    };
  };

  mobile.boot.stage-1 = {
    kernel.package = pkgs.callPackage ./kernel { };
  };

  mobile.system.android.device_name = "mt8167s";
  mobile.system.android.bootimg = {
    flash = {
      offset_base = "0x40078000";
      offset_kernel = "0x00008000";
      offset_ramdisk = "0x14f88000";
      offset_second = "0x00e88000";
      offset_tags = "0x0df88000";
      pagesize = "2048";
    };
  };

  boot.kernelParams = lib.mkMerge [
    [
      # Extracted from vendor image
      "bootopt=64S3,32N2,64N2"
      #"buildvariant=user"
    ]
  ];

  mobile.system.type = "android";
}
