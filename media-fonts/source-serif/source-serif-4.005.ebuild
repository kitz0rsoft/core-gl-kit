# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="Serif font family for user interface environments"
HOMEPAGE="https://adobe-fonts.github.io/source-serif/"
SRC_URI="https://github.com/adobe-fonts/source-serif/tarball/2823e993c53fca27c5c8749f529b56a5a7c77b6b -> source-serif-4.005-2823e99.tar.gz"
LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="*"
IUSE="cjk"

RDEPEND="media-libs/fontconfig
	cjk? ( media-fonts/source-han-sans )"

S="${WORKDIR}/adobe-fonts-source-serif-2823e99"

FONT_CONF=( "${FILESDIR}"/63-${PN}.conf )
RESTRICT="binchecks strip"

src_prepare() {
	default
}

src_install() {
    FONT_S=( "${S}"/OTF "${S}"/VAR )
    FONT_SUFFIX="otf"
    font_src_install

    FONT_S=( "${S}"/TTF "${S}"/VAR )
    FONT_SUFFIX="ttf"
    font_src_install

    FONT_S=( "${S}"/WOFF/OTF "${S}"/WOFF/TTF "${S}"/WOFF/VAR )
    FONT_SUFFIX="woff"
    font_src_install

    FONT_S=( "${S}"/WOFF2/OTF "${S}"/WOFF2/TTF "${S}"/WOFF2/VAR )
    FONT_SUFFIX="woff2"
    font_src_install

    dodoc README.md
}