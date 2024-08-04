# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS="cmake"
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic cmake-utils python-any-r1 toolchain-funcs


DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Loader"
SRC_URI="https://github.com/KhronosGroup/Vulkan-Loader/tarball/5035e37bf6bf6cf4b0c6cf7956c63b0522d69ab9 -> Vulkan-Loader-1.3.236-5035e37.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="layers wayland X"

BDEPEND=">=dev-util/cmake-3.10.2"
DEPEND="
	=dev-util/vulkan-headers-1.3.236*
	${PYTHON_DEPS}
	wayland? ( dev-libs/wayland:= )
	X? (
		x11-libs/libX11:=
		x11-libs/libXrandr:=
	)
"
PDEPEND="layers? ( =media-libs/vulkan-layers-1.3.236*:= )"

post_src_unpack() {
	mv "${WORKDIR}"/KhronosGroup-Vulkan-Loader-* ${S} || die
}

post_src_prepare() {
	# on 64-bit systems, have pkgconfig file reference 'libvulkan' not 'libvulkan64'.
	sed -i -e s'/^Libs:.*$/Libs: -L${libdir} -lvulkan/' loader/vulkan.pc.in || die
}

src_configure() {
	# Integrated clang assembler doesn't work with x86 - Bug #698164
	if tc-is-clang && [[ ${ABI} == x86 ]]; then
		append-cflags -fno-integrated-as
	fi

	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DBUILD_TESTS=OFF
		-DBUILD_LOADER=ON
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DBUILD_WSI_XCB_SUPPORT=$(usex X)
		-DBUILD_WSI_XLIB_SUPPORT=$(usex X)
		-DVULKAN_HEADERS_INSTALL_DIR="${ESYSROOT}/usr"
	)
	cmake-utils_src_configure
}

src_install() {
	keepdir /etc/vulkan/icd.d

	cmake-utils_src_install
}

pkg_postinst() {
	einfo "USE=demos has been dropped as per upstream packaging"
	einfo "vulkaninfo is now available in the dev-util/vulkan-tools package"
}