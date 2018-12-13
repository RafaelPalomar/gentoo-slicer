# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

# Short one-line description of this package.
DESCRIPTION="3D Slicer is an open source software platform for medical image informatics,
image processing, and three-dimensional visualization"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.slicer.org/"

SRC_URI="https://github.com/Slicer/Slicer/archive/v4.10.0.zip"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~amd64"

IUSE="qtloadable"

DEPEND=" sci-medical/CTK
		 sci-medical/teem
		 sci-libs/jqPlot
		 dev-vcs/subversion
		 dev-qt/qtmultimedia
		 dev-qt/qtxmlpatterns
		 dev-qt/qtsvg
		 dev-qt/qtxml
		 dev-qt/qtwebengine[widgets]
		 dev-qt/qtwebchannel
		 qtloadable? ( dev-libs/rapidjson )
"
RDEPEND="${DEPEND}"

PATCHES=(
	${FILESDIR}/${PN}-${PV}-Adding-check-of-Slicer_USE_CTKAPPLAUNCHER-variable.patch
	${FILESDIR}/${PN}-${PV}-Fixing-ITK-dependences-for-vtkITK.patch
	${FILESDIR}/${PN}-${PV}-Fixing-ITK-dependences-for-vtkTeem.patch
	${FILESDIR}/${PN}-${PV}-Fix-ITK-and-VTK-dependences-for-MRML-Core.patch
	${FILESDIR}/${PN}-${PV}-Remove-dependence-of-ctkAppLauncher-from-qSlicerCore.patch
	${FILESDIR}/${PN}-${PV}-Fix-ITK-requirements-for-Slicer-Base-QtCore.patch
#	${FILESDIR}/${PN}-${PV}-Remove_CPack_from_LastConfigureStep.patch
	${FILESDIR}/${PN}-${PV}-Fix-inclusion-of-QDomDocument-in-Plots-logic.patch
	${FILESDIR}/${PN}-${PV}-Enable-install-of-development-files.patch
	${FILESDIR}/${PN}-${PV}-Fix-installation-path-for-development-files.patch
	${FILESDIR}/${PN}-${PV}-Fix-path-for-installation-of-utility-scripts.patch
	${FILESDIR}/${PN}-${PV}-Fix-conditional-build-testing-QTCore.patch
	${FILESDIR}/${PN}-${PV}-Fix-conditional-build-testing-in-QTGUI.patch
	${FILESDIR}/${PN}-${PV}-Conditional-include-of-CTKAppLauncherLib.patch
	${FILESDIR}/${PN}-${PV}-Fix-find-SlicerBlockFindQtAndCheckVersion_cmake-on-SlicerConfig_cmake.patch
	${FILESDIR}/${PN}-${PV}-Fix-install-configuration.patch
	${FILESDIR}/${PN}-${PV}-Fix-installation-of-template-files.patch
	${FILESDIR}/${PN}-${PV}-Fix-template-directory-configuration.patch
	${FILESDIR}/${PN}-${PV}-Fix-library-destination-for-install-of-module-libraries.patch
	${FILESDIR}/${PN}-${PV}-Fix-development-paths.patch
	${FILESDIR}/${PN}-${PV}-Add-CTK_QT_VERSION-variable-to-SlicerConfig.patch
	${FILESDIR}/${PN}-${PV}-Fix-include-qt5-in-SlicerUse-template-file.patch
	${FILESDIR}/${PN}-${PV}-Set-development-configuration-variables.patch
	${FILESDIR}/${PN}-${PV}-Include-find-package-forITK-and-vtk-in-UseSlicer-template.patch
	${FILESDIR}/${PN}-${PV}-Enable-Slicer-INSTALL-DEVELOPMENT-option.patch
	${FILESDIR}/${PN}-${PV}-Fix-gobbling-pattern-for-installation-of-development-files-in-vtkAddon.patch
	${FILESDIR}/${PN}-${PV}-Adding-MRML-libraries-to-SlicerConfig-template.patch
	${FILESDIR}/${PN}-${PV}-Set-3DSlicer-link-directories.patch
	${FILESDIR}/${PN}-${PV}-Adding-VTK-link-libraries-to-MacroBuildModuleVTKLibrary.patch
	${FILESDIR}/${PN}-${PV}-Fix-set-of-install-development-flag-on-Logic.patch
	${FILESDIR}/${PN}-${PV}-Fix-install-path-for-Base-Logic-headers.patch
	${FILESDIR}/${PN}-${PV}-Fix-include-path-for-qSlicerBaseQTGUI.patch
	${FILESDIR}/${PN}-${PV}-Include-CTK-in-SlicerUse-file.patch
	${FILESDIR}/${PN}-${PV}-Fix-including-of-qSlicerBaseQTCore-directory.patch
	${FILESDIR}/${PN}-${PV}-Add-Slicer-qt-core-libraries-for-linking.patch
	${FILESDIR}/${PN}-${PV}-Fix-qSlicerBase-variables.patch
	${FILESDIR}/${PN}-${PV}-Include-CTK-libraries-for-linking-Loadable-Modules.patch
	${FILESDIR}/${PN}-${PV}-Add-Xml-component-for-Qt5-in-UseSlicer-file.patch
	${FILESDIR}/${PN}-${PV}-Add-Network-component-for-Qt5-in-UseSlicer-file.patch
	${FILESDIR}/${PN}-${PV}-Add-qMRMLWidgets-include-directory.patch
	${FILESDIR}/${PN}-${PV}-Include-Qt-dirs-in-macro-for-building-logic.patch
	${FILESDIR}/${PN}-${PV}-Include-VTK-in-slicer-build-logic-macro.patch
	${FILESDIR}/${PN}-${PV}-Include-VTK-modules-in-SlicerUse.patch
	${FILESDIR}/${PN}-${PV}-Fix-Slicer_INSTALL_DEVELOPMENT-variable-name.patch
	${FILESDIR}/${PN}-${PV}-Fix-destination-of-loadable-modules-include-files.patch
	${FILESDIR}/${PN}-${PV}-Add-qtloadable-modules-includes-dirs-in-BuildModuleLogic.patch
	${FILESDIR}/${PN}-${PV}-Change-install-paths-for-development-files.patch
	${FILESDIR}/${PN}-${PV}-Adding-Qt5-Webkit-to-the-list-of-required-modules.patch
	${FILESDIR}/${PN}-${PV}-Add-link-libraries-build-module-logic-macro.patch
)

src_unpack() {
	if [ "${A}"  != "" ]; then
		unpack ${A}
	fi

	mv ${WORKDIR}/Slicer-${PV} ${WORKDIR}/${PN}-${PV}
}

src_prepare() {

	cmake-utils_src_prepare
}

src_configure(){

	local mycmakeargs=()

	mycmakeargs+=(
		-DSlicer_SUPERBUILD=OFF
		-DBUILD_TESTING=OFF
		-DSlicer_BUILD_EXTENSIONMANAGER_SUPPORT=OFF
		-DSlicer_BUILD_CLI_SUPPORT=OFF
		-DSlicer_BUILD_CLI=OFF
		-DCMAKE_CXX_STANDARD=11
		-DSlicer_REQUIRED_QT_VERSION=5.9.6
		-DSlicer_BUILD_DICOM_SUPPORT=OFF
		-DSlicer_BUILD_ITKPython=OFF
		-DSlicer_BUILD_QTLOADABLEMODULES=$(usex qtloadable)
		-DSlicer_BUILD_QT_DESIGNER_PLUGINS=OFF
		-DSlicer_USE_CTKAPPLAUNCHER=OFF
		-DSlicer_USE_PYTHONQT=OFF
		-DSlicer_USE_QtTesting=OFF
		-DSlicer_USE_SimpleITK=OFF
		-DSlicer_VTK_RENDERING_BACKEND=OpenGL2
		-DSlicer_VTK_VERSION_MAJOR=8
		-DTeem_DIR=/usr/lib64
		-DjqPlot_DIR=/usr/share/jqPlot
		-DSlicer_INSTALL_DEVELOPMENT=ON
		-DCMAKE_INSTALL_RPATH=/usr/lib64/Slicer-4.10:/usr/lib64/ctk-0.1:/usr/lib64/Slicer-4.10/qt-loadable-modules
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
		-DSlicer_USE_SYSTEM_LibArchive=ON
#		-DSlicer_SKIP_SlicerBlockAdditionalLauncherSettings=ON
#		-DSlicer_DONT_USE_EXTENSION=ON
	)
	cmake-utils_src_configure
}
