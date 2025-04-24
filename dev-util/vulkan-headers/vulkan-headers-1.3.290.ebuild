# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Vulkan Header files and API registry"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Headers"
SRC_URI="https://github.com/KhronosGroup/Vulkan-Headers/tarball/b379292b2ab6df5771ba9870d53cf8b2c9295daf -> Vulkan-Headers-1.3.290-b379292.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

BDEPEND=">=dev-util/cmake-3.10.2"

post_src_unpack() {
	mv "${WORKDIR}"/KhronosGroup-Vulkan-Headers-* "${S}" || die
}