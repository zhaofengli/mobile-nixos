{ lib
, stdenv
, fetchFromGitLab
, meson
, ninja
, pkg-config
, glib
, glibmm
, libgpiod
, libgudev
, libusb
, curl
, eggdbus
, modemmanager
}:

stdenv.mkDerivation rec {
  pname = "eg25-manager";
  version = "0.4.6";

  src = fetchFromGitLab {
    domain = "gitlab.com";
    owner = "mobian1";
    repo = pname;
    rev = version;
    hash = "sha256-2JsdwK1ZOr7ljNHyuUMzVCpl+HV0C5sA5LAOkmELqag=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    curl
    eggdbus
    glib
    glibmm
    libgpiod
    libgudev
    libusb
    modemmanager
  ];

  meta = with lib; {
    description = "Manager daemon for the Quectel EG25 mobile broadband modem";
    homepage = "https://gitlab.com/mobian1/devices/eg25-manager";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ tomfitzhenry ];
    platforms = platforms.linux;
  };
}
