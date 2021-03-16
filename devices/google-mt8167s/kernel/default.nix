{ lib
, mobile-nixos
, fetchFromGitHub
, python2
, ...
}:

mobile-nixos.kernel-builder-gcc49 {
  version = "4.4.95";
  configfile = ./config.aarch64;

  src = fetchFromGitHub {
    owner = "deadman96385";
    repo = "android_kernel_lenovo_mt8167s";
    rev = "96807f7f2d508963c41b60eed438cc8385ad01fc";
    sha256 = "0gwl99svd71590fgmph4gy81qr8ibrz93ggdd46s67hhwq77mhhf";
  };

  nativeBuildInputs = [ python2 ];

  enableRemovingWerror = false;
  isImageGzDtb = true;
  isModular = false;
}
