cmake_minimum_required(VERSION 3.16)

project(Calc VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appCalc
    main.cpp
)

qt_add_qml_module(appCalc
    URI Calc
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES calculatorengine.h calculatorengine.cpp
        SOURCES calculatorviewmodel.h calculatorviewmodel.cpp
        QML_FILES CircleButton.qml
        QML_FILES CircleSymbolButton.qml
        QML_FILES SecretMenu.qml
        RESOURCES Resources.qrc
)

qt_add_resources(appCalc "Resources"
    PREFIX "/"
    FILES
        images/status_bar_contents.png images/bkt.png images/division.png images/equal.png images/minus.png images/multiplication.png  images/percent.png images/plus.png images/plus_minus.png

)
# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCalc PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCalc
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCalc
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appCalc
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
