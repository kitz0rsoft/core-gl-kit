# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit cmake-utils python-any-r1

DESCRIPTION="OpenCL Host API C++ bindings."
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-CLHPP"
SRC_URI="https://github.com/KhronosGroup/OpenCL-CLHPP/tarball/a029285574d7262dc1baa62706c777603b453f8a -> OpenCL-CLHPP-2024.05.08-a029285.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

IUSE="doc"

# Old packaging will cause file collisions
RDEPEND="
	>=dev-util/opencl-headers-${PV}
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/KhronosGroup-OpenCL-CLHPP-* "${S}" || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS=$(usex doc OFF ON)
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTS=OFF
		-DOPENCL_INCLUDE_DIR=${EPREFIX}/usr/include/CL
		-DBUILD_TESTING=OFF
	)

	cmake-utils_src_configure
}