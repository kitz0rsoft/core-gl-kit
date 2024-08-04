# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Platform-agnostic interfaces for WPE WebKit"
HOMEPAGE="https://wpewebkit.org/"
SRC_URI="https://api.github.com/repos/WebPlatformForEmbedded/libwpe/tarball/1.16.0 -> libwpe-1.16.0.tar.gz"

LICENSE="BSD-2"
SLOT="1.0"
IUSE=""

KEYWORDS="*"

RDEPEND="
	media-libs/mesa[egl]
	x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

post_src_unpack() {
	mv "${WORKDIR}/"WebPlatformForEmbedded-libwpe* "${S}" || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS=OFF # hotdoc not packaged
	)

	cmake_src_configure
}