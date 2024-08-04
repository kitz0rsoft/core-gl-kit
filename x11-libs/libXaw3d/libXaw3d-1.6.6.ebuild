# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xorg-3

DESCRIPTION="X.Org Xaw3d library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libxaw3d"
SRC_URI="https://www.x.org/releases/individual/lib/libXaw3d-1.6.6.tar.xz -> libXaw3d-1.6.6.tar.xz
"

KEYWORDS="*"
IUSE="unicode xpm"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXt"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc
	x11-base/xorg-proto"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable unicode internationalization)
		$(use_enable xpm multiplane-bitmaps)
		--enable-arrow-scrollbars
		--enable-gray-stipples
	)

	xorg-3_pkg_setup
}