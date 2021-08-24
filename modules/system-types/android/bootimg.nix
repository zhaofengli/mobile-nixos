{ lib
, pkgs
, name

# mkbootimg specific values
, kernel
, initrd
, cmdline
, bootimg
}:

let
  inherit (lib) optionalString;
  inherit (pkgs) buildPackages;
in
pkgs.runCommandNoCC name {
  nativeBuildInputs = with buildPackages; [
    mtk-mkimage
    mkbootimg
    dtbTool
  ];
} ''
  kernel=${kernel}
  initrd=${initrd}

  echo ":: Using kernel: $kernel"
  echo ":: Using initrd: $initrd"

  if [ -n "${builtins.toString bootimg.mtkHeaders}" ]; then
    echo ":: Prepending MTK headers"

    echo ":: Kernel: $kernel -> kernel-mtk"
    mtk-mkimage KERNEL $kernel kernel-mtk
    kernel=kernel-mtk

    echo ":: Kernel: $initrd -> initrd-mtk"
    mtk-mkimage ROOTFS $initrd initrd-mtk
    initrd=initrd-mtk
  fi

  (
  PS4=" $ "
  set -x
  mkbootimg \
    --kernel  $kernel \
    ${optionalString (bootimg.dt != null) "--dt ${bootimg.dt}"} \
    --ramdisk $initrd \
    --cmdline       "${cmdline}" \
    --base           ${bootimg.flash.offset_base   } \
    --kernel_offset  ${bootimg.flash.offset_kernel } \
    --second_offset  ${bootimg.flash.offset_second } \
    --ramdisk_offset ${bootimg.flash.offset_ramdisk} \
    --tags_offset    ${bootimg.flash.offset_tags   } \
    --pagesize       ${bootimg.flash.pagesize      } \
    -o $out
  )
''
