# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

DESCRIPTION="Monospaced font family for user interface and coding environments"
HOMEPAGE="https://github.com/adobe-fonts/source-code-pro"
SRC_URI="https://github.com/adobe-fonts/source-code-pro/tarball/a0e3aa19323549af1e6f60a1ebf32b912bc1a497 -> source-code-pro-2.042-a0e3aa1.tar.gz"
LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="*"
IUSE="cjk"

RDEPEND="media-libs/fontconfig
	cjk? ( media-fonts/source-han-sans )"

S="${WORKDIR}/adobe-fonts-source-code-pro-a0e3aa1"

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