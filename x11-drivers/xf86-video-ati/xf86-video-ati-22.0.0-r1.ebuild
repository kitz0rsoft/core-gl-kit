# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools linux-info flag-o-matic

DESCRIPTION="Driver for xorg-server"
KEYWORDS="*"
IUSE="+glamor udev "
SRC_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/archive/xf86-video-ati-22.0.0/xf86-video-ati-xf86-video-ati-22.0.0.tar.bz2 -> xf86-video-ati-22.0.0-gitlab.tar.bz2"
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
	${DEPEND}x11-libs/libpciaccess
	x11-libs/libdrm[video_cards_radeon]
x11-base/xorg-server[glamor(+),-minimal]
udev? ( virtual/libudev:= )

"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
AUTOTOOLS_AUTORECONF="1"

pkg_setup() {
	append-ldflags -Wl,-z,lazy
}
src_prepare() {
	# gcc-10 fix:
	sed -i -e 's/^miPointerSpriteFuncRec/extern miPointerSpriteFuncRec/' ${S}/src/drmmode_display.h || die
	eautoreconf || die
	default
	
}
src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		--enable-glamor
$(use_enable udev)

	)
	econf ${XORG_CONFIGURE_OPTIONS[@]} || die
}
pkg_pretend() {
	CONFIG_CHECK="~!DRM_RADEON_UMS ~!FB_RADEON "
	check_extra_config
}

pkg_postinst() {
	CONFIG_CHECK="~!DRM_RADEON_UMS ~!FB_RADEON "
	check_extra_config
}


src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
}
