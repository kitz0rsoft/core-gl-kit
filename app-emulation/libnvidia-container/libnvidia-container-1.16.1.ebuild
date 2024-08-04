# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="NVIDIA container runtime library and nvidia-container-cli tool"
HOMEPAGE="https://github.com/NVIDIA/libnvidia-container"
SRC_URI="
    
	    https://github.com/NVIDIA/libnvidia-container/tarball/4c2494f16573b585788a42e9c7bee76ecd48c73d -> libnvidia-container-1.16.1-4c2494f.tar.gz
	
	    https://github.com/NVIDIA/nvidia-modprobe/tarball/149440ca0654d928f27df5ebff485a122bfe43b1 -> nvidia-modprobe-550.54.14-149440c.tar.gz
	
	    https://sourceforge.net/projects/elftoolchain/files/Sources/elftoolchain-0.7.1/elftoolchain-0.7.1.tar.bz2 -> elftoolchain-0.7.1.tar.bz2
	
"
LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	net-libs/libtirpc:=
	sys-libs/libcap
	sys-libs/libseccomp
	virtual/libelf:=
	x11-drivers/nvidia-drivers
	x11-drivers/nvidia-kernel-modules
"

DEPEND="${RDEPEND}"

BDEPEND="
	sys-devel/bmake
	dev-lang/go
	net-libs/rpcsvc-proto
	sys-apps/lsb-release
	virtual/pkgconfig
"

post_src_unpack() {
	# Rename the main source directory to the expected name
	mv NVIDIA-libnvidia-container* "${S}" || die

	DEPSDIR="${S}/deps/src"

	# Put the nvidia-modprobe sources into the right location
	NVDIR="${DEPSDIR}"/nvidia-modprobe-550.54.14
	mkdir -p "${NVDIR}"
	mv NVIDIA-nvidia-modprobe-*/modprobe-utils "${NVDIR}"

	# Put some dirs from the elftoolchain sources into the right location
	ELFDIR="${DEPSDIR}"/elftoolchain-0.7.1
	mkdir -p "${ELFDIR}"
	mv elftoolchain-0.7.1/{common,libelf,mk} "${ELFDIR}"
}

src_prepare() {
	default

	# Don't fetch the sources for nvidia-modprobe and elftoolchain from the internet during src_compile()
	sed -i \
		-e '/CURL/ d' \
		-e '/TAR/ d' \
		mk/nvidia-modprobe.mk || die

	sed -i \
		-e '/CURL/ d' \
		-e '/TAR/ d' \
		mk/elftoolchain.mk || die
}

src_compile() {
	:;
}

src_install() {
	append-flags -I/usr/include/tirpc -ltirpc
	append-ldflags -Wl,-ltirpc

	emake \
	    DESTDIR=${D} \
		REVISION=${PV} \
		LIB_VERSION=${PV} \
		install

		# This script loads necessary module and performs some initialization steps.
    	newinitd $FILESDIR/nvidia-container.initd nvidia-container
}