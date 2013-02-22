#/**********************************************************\ 
#Original Author: Richard Bateman (taxilian)
#
#Created:    Nov 20, 2009
#License:    Dual license model; choose one of two:
#            New BSD License
#            http://www.opensource.org/licenses/bsd-license.php
#            - or -
#            GNU Lesser General Public License, version 2.1
#            http://www.gnu.org/licenses/lgpl-2.1.html
#            
#Copyright 2009 PacketPass, Inc and the Firebreath development team
#\**********************************************************/

# Windows template platform definition CMake file
# Included from ../CMakeLists.txt

file (GLOB PLATFORM RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    Win/*.cpp
    Win/*.h
    Win/*.cmake
    )

add_definitions(
    /D "_ATL_STATIC_REGISTRY"
)

SOURCE_GROUP(Win FILES ${PLATFORM})

set (SOURCES
    ${SOURCES}
    ${PLATFORM}
    )

add_windows_plugin(${PROJECT_NAME} SOURCES)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg)

# add library dependencies here; leave ${PLUGIN_INTERNAL_DEPS} there unless you know what you're doing!
target_link_libraries(${PROJECT_NAME}
    ${PLUGIN_INTERNAL_DEPS}
    Strmiids.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/libxplayer.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/lib/libavcodec.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/lib/libswscale.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/lib/libavutil.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/lib/libavfilter.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/lib/libavformat.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/lib/libswresample.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/libmsys/libmingwex.lib
    ${CMAKE_CURRENT_SOURCE_DIR}/../../libffmpeg/libmsys/libgcc.lib
    )

# IF(${_MACHINE_ARCH_FLAG} MATCHES X86)
  SET (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /SAFESEH:NO")
  SET (CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /SAFESEH:NO")
  SET (CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} /SAFESEH:NO")
# ENDIF()

set(WIX_HEAT_FLAGS
    -gg                 # Generate GUIDs
    -srd                # Suppress Root Dir
    -cg PluginDLLGroup  # Set the Component group name
    -dr INSTALLDIR      # Set the directory ID to put the files in
    )
    
add_wix_installer( ${PLUGIN_NAME}
    ${CMAKE_CURRENT_SOURCE_DIR}/Win/WiX/SPlayerInstaller.wxs
    PluginDLLGroup
    ${FB_BIN_DIR}/${PLUGIN_NAME}/${CMAKE_CFG_INTDIR}/
    ${FB_BIN_DIR}/${PLUGIN_NAME}/${CMAKE_CFG_INTDIR}/${FBSTRING_PluginFileName}.dll
    ${PROJECT_NAME}
    )
