cmake_minimum_required(VERSION 3.16)
project(cutie-contacts VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_DEFAULT_MAJOR_VERSION 6)
set(QAPPLICATION_CLASS QApplication)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Qml LinguistTools)

qt_standard_project_setup()

set(cutie-contacts_SOURCES src/main.cpp)

qt_add_resources(APP_RESOURCES 
	${CMAKE_SOURCE_DIR}/src/qml/qml.qrc)

qt_add_executable(cutie-contacts ${cutie-contacts_SOURCES} ${APP_RESOURCES})

qt_add_translations(cutie-contacts
    TS_FILES ${CMAKE_SOURCE_DIR}/translations/cutie-contacts_fi.ts)

target_include_directories(cutie-contacts PUBLIC src)

target_link_libraries(cutie-contacts PUBLIC Qt::Core Qt::Quick Qt::Qml Qt::DBus)

install(TARGETS cutie-contacts RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")
install(FILES cutie-contacts.desktop DESTINATION "${CMAKE_INSTALL_DATADIR}/applications")
install(FILES cutie-contacts.svg DESTINATION "${CMAKE_INSTALL_DATADIR}/icons/hicolor/scalable/apps")