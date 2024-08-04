# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS="cmake"
PYTHON_COMPAT=( python3+ )
inherit cmake-utils python-any-r1

DESCRIPTION="Vulkan Validation Layers"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-ValidationLayers"
SRC_URI="https://github.com/KhronosGroup/Vulkan-ValidationLayers/tarball/69a57f610c04cf8b7ae2f704bfcea51b41760a16 -> Vulkan-ValidationLayers-1.3.236-69a57f6.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="wayland X"

BDEPEND=">=dev-util/cmake-3.10.2"
DEPEND="
	=dev-util/glslang-1.3.236.0_p20221013*
	=dev-util/spirv-tools-2022.2_p20221110*
	=dev-util/vulkan-headers-1.3.236*
	${PYTHON_DEPS}
	dev-cpp/robin-hood-hashing
	wayland? ( dev-libs/wayland:= )
	X? (
		x11-libs/libX11:=
		x11-libs/libXrandr:=
	)
"

post_src_unpack() {
	mv "${WORKDIR}"/KhronosGroup-Vulkan-ValidationLayers-* "${S}" || die
}

post_src_prepare() {
	# FL-9238: dealing with an upstream change where the link was to the wrong dir. This probably won't be needed forever:
	# https://github.com/KhronosGroup/Vulkan-ValidationLayers/commit/2c2b81c05189790acfea79873f1ea689827ad998#diff-ff032a8648100262964374becd9dd6fa56d9d1c02c6596a83128241ff668038bR307

	sed -i \
		-e '/target_link_libraries.*VkLayer_khronos_validation PRIVATE.*SPIRV-Tools-static/s/SPIRV-Tools-static/SPIRV-Tools/' \
	"${S}"/layers/CMakeLists.txt || ewarn "The fix for FL-9238 can likely be removed from the vulkan-layers autogen now."
	return 0
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DBUILD_LAYER_SUPPORT_FILES=ON
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DBUILD_WSI_XCB_SUPPORT=$(usex X)
		-DBUILD_WSI_XLIB_SUPPORT=$(usex X)
		-DBUILD_TESTS=OFF
		-DGLSLANG_INSTALL_DIR="${EPREFIX}/usr"
		-DCMAKE_INSTALL_INCLUDEDIR="${EPREFIX}/usr/include/"
		-DSPIRV_HEADERS_INSTALL_DIR="${EPREFIX}/usr"
		-DVulkanRegistry_DIR="${EPREFIX}/usr/share/vulkan/registry"
	)
	cmake-utils_src_configure
}