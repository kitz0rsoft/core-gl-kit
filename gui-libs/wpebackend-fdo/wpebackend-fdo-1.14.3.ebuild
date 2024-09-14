# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson 

DESCRIPTION="WPE backend designed for Linux desktop systems"
HOMEPAGE="https://wpewebkit.org/"
SRC_URI="https://api.github.com/repos/Igalia/WPEBackend-fdo/tarball/1.14.3 -> wpebackend-fdo-1.14.3.tar.gz"

LICENSE="BSD-2"
SLOT="1.0"
IUSE=""

KEYWORDS="*"

RDEPEND="
	media-libs/mesa[egl]
	dev-libs/glib:2
	>=dev-libs/wayland-1.10
	>=gui-libs/libwpe-1.6:1.0
"
DEPEND="${RDEPEND}"
BDEPEND="
    dev-util/wayland-scanner
	virtual/pkgconfig
"


post_src_unpack() {
	mv "${WORKDIR}/"Igalia-WPEBackend-fdo* "${S}" || die
}

src_configure() {
	local emesonargs=(
		-Dbuild_docs=false # hotdoc not packaged
	)

	meson_src_configure
}