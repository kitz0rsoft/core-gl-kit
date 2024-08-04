# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Unified C language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-Headers"
SRC_URI="https://github.com/KhronosGroup/OpenCL-Headers/tarball/8275634cf9ec31b6484c2e6be756237cb583999d -> OpenCL-Headers-2024.05.08-8275634.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/KhronosGroup-OpenCL-Headers-* "${S}" || die
}