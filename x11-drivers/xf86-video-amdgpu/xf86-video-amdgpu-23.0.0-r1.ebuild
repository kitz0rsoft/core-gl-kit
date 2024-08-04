# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools linux-info flag-o-matic

DESCRIPTION="Driver for xorg-server"
KEYWORDS="*"
IUSE=" "
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/-/archive/xf86-video-amdgpu-23.0.0/xf86-video-amdgpu-xf86-video-amdgpu-23.0.0.tar.bz2 -> xf86-video-amdgpu-23.0.0-gitlab.tar.bz2"
SLOT="0"
S="$WORKDIR/${PN}-${P}"
DEPEND="
	x11-base/xorg-proto
	x11-base/xorg-server
	>=sys-devel/libtool-2.2.6a
	sys-devel/m4
	>=x11-misc/util-macros-1.18
	
	x11-base/xorg-server[-minimal]
	x11-libs/libdrm
"

RDEPEND="
	${DEPEND}x11-libs/libpciaccess
	x11-libs/libdrm[video_cards_amdgpu]
x11-base/xorg-server[glamor(+),-minimal]

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
		--enable-glamor

	)
	econf ${XORG_CONFIGURE_OPTIONS[@]} || die
}


src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
}
