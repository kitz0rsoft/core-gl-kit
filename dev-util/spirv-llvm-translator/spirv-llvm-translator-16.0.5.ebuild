# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic llvm


DESCRIPTION="Bi-directional translator between SPIR-V and LLVM IR"
HOMEPAGE="https://github.com/KhronosGroup/SPIRV-LLVM-Translator"
SRC_URI="https://github.com/KhronosGroup/SPIRV-LLVM-Translator/tarball/3bf65aad340cc2daf315f84b4f3e05cdd512c5e7 -> SPIRV-LLVM-Translator-16.0.5-3bf65aa.tar.gz"

LICENSE="UoI-NCSA"
SLOT="$(ver_cut 1)"
KEYWORDS="*"
IUSE="tools"

RESTRICT="test"

DEPEND="
    sys-devel/clang:${SLOT}=
    dev-util/spirv-headers
    "
RDEPEND="${DEPEND}"

LLVM_MAX_SLOT=${SLOT}

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}"/KhronosGroup-SPIRV-LLVM-Translator-* "${S}" || die
}

src_prepare() {
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="$(get_llvm_prefix ${LLVM_MAX_SLOT})"
		-DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="${ESYSROOT}/usr/include/spirv"
		-DLLVM_BUILD_TOOLS=$(usex tools "ON" "OFF")
	)
	cmake-utils_src_configure
}