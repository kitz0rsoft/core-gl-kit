# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools linux-info flag-o-matic udev

DESCRIPTION="Driver for xorg-server"
KEYWORDS="*"
IUSE=" "
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-input-vmmouse/-/archive/xf86-input-vmmouse-13.2.0/xf86-input-vmmouse-xf86-input-vmmouse-13.2.0.tar.bz2 -> xf86-input-vmmouse-13.2.0-gitlab.tar.bz2"
SLOT="0"
S="$WORKDIR/${PN}-${P}"
DEPEND="
	x11-base/xorg-proto
	x11-base/xorg-server
	>=sys-devel/libtool-2.2.6a
	sys-devel/m4
	>=x11-misc/util-macros-1.18
	
"

RDEPEND="
	${DEPEND}
	
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
src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		--with-hal-bin-dir=/punt
--with-hal-callouts-dir=/punt
--with-hal-fdi-dir=/punt
--with-udev-rules-dir=$(get_udevdir)/rules.d

	)
	econf ${XORG_CONFIGURE_OPTIONS[@]} || die
}


src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	rm -rf "${ED}"/punt
	
}
