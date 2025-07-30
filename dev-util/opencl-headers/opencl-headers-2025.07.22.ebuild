# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Unified C language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-Headers"
SRC_URI="https://github.com/KhronosGroup/OpenCL-Headers/tarball/8a97ebc88daa3495d6f57ec10bb515224400186f -> OpenCL-Headers-2025.07.22-8a97ebc.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/KhronosGroup-OpenCL-Headers-* "${S}" || die
}