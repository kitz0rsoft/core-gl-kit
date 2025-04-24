# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="Sans serif font family for user interface environments"
HOMEPAGE="https://adobe-fonts.github.io/source-sans/"
SRC_URI="https://github.com/adobe-fonts/source-sans/tarball/5d173ba058bda87bcff2bb2d53b9d2c59d440ff6 -> source-sans-3.052-5d173ba.tar.gz"
LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="*"
IUSE="cjk"

RDEPEND="media-libs/fontconfig
	cjk? ( media-fonts/source-han-sans )"

S="${WORKDIR}/adobe-fonts-source-sans-5d173ba"

FONT_CONF=( "${FILESDIR}"/63-${PN}.conf )
RESTRICT="binchecks strip"

src_prepare() {
	default
}

src_install() {
    FONT_S=( "${S}"/OTF "${S}"/VF )
    FONT_SUFFIX="otf"
    font_src_install

    FONT_S=( "${S}"/TTF "${S}"/VF )
    FONT_SUFFIX="ttf"
    font_src_install

    FONT_S=( "${S}"/WOFF/OTF "${S}"/WOFF/TTF "${S}"/WOFF/VF )
    FONT_SUFFIX="woff"
    font_src_install

    FONT_S=( "${S}"/WOFF2/OTF "${S}"/WOFF2/TTF "${S}"/WOFF2/VF )
    FONT_SUFFIX="woff2"
    font_src_install

    dodoc README.md
}