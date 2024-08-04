# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools linux-info flag-o-matic

DESCRIPTION="Driver for xorg-server"
KEYWORDS="*"
IUSE="ztv "
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-geode/-/archive/xf86-video-geode-2.11.21/xf86-video-geode-xf86-video-geode-2.11.21.tar.bz2 -> xf86-video-geode-2.11.21-gitlab.tar.bz2"
SLOT="0"
S="$WORKDIR/${PN}-${P}"
DEPEND="
	x11-base/xorg-proto
	x11-base/xorg-server
	>=sys-devel/libtool-2.2.6a
	sys-devel/m4
	>=x11-misc/util-macros-1.18
	ztv? ( sys-kernel/linux-headers )

"

RDEPEND="
	${DEPEND}x11-libs/libpciaccess
	
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
		$(use_enable ztv)

	)
	econf ${XORG_CONFIGURE_OPTIONS[@]} || die
}


src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
}
