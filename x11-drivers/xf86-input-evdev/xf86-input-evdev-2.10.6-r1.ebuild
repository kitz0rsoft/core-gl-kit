# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools linux-info flag-o-matic

DESCRIPTION="Driver for xorg-server"
KEYWORDS="*"
IUSE=" "
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-input-evdev/-/archive/xf86-input-evdev-2.10.6/xf86-input-evdev-xf86-input-evdev-2.10.6.tar.bz2 -> xf86-input-evdev-2.10.6-gitlab.tar.bz2"
SLOT="0"
S="$WORKDIR/${PN}-${P}"
DEPEND="sys-kernel/linux-headers
	x11-base/xorg-proto
	x11-base/xorg-server
	>=sys-devel/libtool-2.2.6a
	sys-devel/m4
	>=x11-misc/util-macros-1.18
	
"

RDEPEND="
	${DEPEND}
	x11-base/xorg-server[udev]
dev-libs/libevdev
sys-libs/mtdev
virtual/libudev:=

"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
AUTOTOOLS_AUTORECONF="1"

pkg_setup() {
	append-ldflags -Wl,-z,lazy
}
src_prepare() {
	eautoreconf || die
	default
}
pkg_pretend() {
	CONFIG_CHECK="~INPUT_EVDEV "
	check_extra_config
}

pkg_postinst() {
	CONFIG_CHECK="~INPUT_EVDEV "
	check_extra_config
}


src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
}
