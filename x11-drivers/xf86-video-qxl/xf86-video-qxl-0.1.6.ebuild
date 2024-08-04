# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
inherit autotools linux-info flag-o-matic python-single-r1

DESCRIPTION="Driver for xorg-server"
KEYWORDS="*"
IUSE="xspice "
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-qxl/-/archive/xf86-video-qxl-0.1.6/xf86-video-qxl-xf86-video-qxl-0.1.6.tar.bz2 -> xf86-video-qxl-0.1.6-gitlab.tar.bz2"
SLOT="0"
S="$WORKDIR/${PN}-${P}"
DEPEND="
	x11-base/xorg-proto
	x11-base/xorg-server
	>=sys-devel/libtool-2.2.6a
	sys-devel/m4
	>=x11-misc/util-macros-1.18
	>=x11-base/xorg-server-1.20.10-r2
>=app-emulation/spice-protocol-0.12.0

"

RDEPEND="
	${DEPEND}x11-libs/libpciaccess
	xspice? (
  app-emulation/spice
  ${PYTHON_DEPS}
)
x11-libs/libdrm

"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
AUTOTOOLS_AUTORECONF="1"

pkg_setup() {
	python-single-r1_pkg_setup
	append-ldflags -Wl,-z,lazy
}
src_prepare() {
	default
	eautoreconf || die
	python_fix_shebang scripts
	
}
src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable xspice)

	)
	econf ${XORG_CONFIGURE_OPTIONS[@]} || die
}


src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
}
