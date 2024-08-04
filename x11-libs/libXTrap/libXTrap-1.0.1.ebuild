# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xorg-3

DESCRIPTION="X.Org XTrap library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libxtrap"
SRC_URI="https://www.x.org/releases/individual/lib/libXTrap-1.0.1.tar.gz -> libXTrap-1.0.1.tar.gz
"

KEYWORDS="*"
IUSE=""

RDEPEND="x11-base/xorg-proto
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt"
DEPEND="${RDEPEND}"