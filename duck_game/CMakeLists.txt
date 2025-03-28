cmake_minimum_required(VERSION 3.16)

project(duck_game VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appduck_game
    main.cpp
)

qt_add_qml_module(appduck_game
    URI duck_game
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES
        QML_FILES Instruction.qml
        QML_FILES game.qml
        SOURCES game.h game.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appduck_game PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appduck_game
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appduck_game
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appduck_game
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
