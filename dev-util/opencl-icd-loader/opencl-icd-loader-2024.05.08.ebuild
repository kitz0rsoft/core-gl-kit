# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake multibuild prefix

DESCRIPTION="Official Khronos OpenCL ICD Loader"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-ICD-Loader"
SRC_URI="https://github.com/KhronosGroup/OpenCL-ICD-Loader/tarball/861b68b290e76d08e7241608479c16431f529945 -> OpenCL-ICD-Loader-2024.05.08-861b68b.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="!dev-libs/ocl-icd"
DEPEND="${RDEPEND}
	>=dev-util/opencl-headers-${PV}"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/KhronosGroup-OpenCL-ICD-Loader-* "${S}" || die
}

src_prepare() {
	hprefixify loader/icd_platform.h
	cmake_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

multilib_src_test() {
	local -x OCL_ICD_FILENAMES="${BUILD_DIR}/test/driver_stub/libOpenCLDriverStub.so"
	local -x OCL_ICD_VENDORS="/dev/null"
	cmake_src_test
}