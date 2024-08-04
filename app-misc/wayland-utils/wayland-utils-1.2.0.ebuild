# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Display information about supported Wayland protocols and current compositor"
HOMEPAGE="https://gitlab.freedesktop.org/wayland/wayland-utils"
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland-utils/-/archive/1.2.0/wayland-utils-v1.2.0.tar.bz2 -> wayland-utils-v1.2.0.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	>=dev-libs/wayland-1.20.0
	>=x11-libs/libdrm-2.4.109
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="dev-util/wayland-scanner"

post_src_unpack() {
	if [ ! -d "${WORKDIR}/${S}" ]; then
		mv "${WORKDIR}"/* "${S}" || die
	fi
}

src_configure() {
	local emesonargs=(
		-Ddrm=enabled
	)
	meson_src_configure
}