# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-cpr-metronome

CONFIG += sailfishapp_qml

DEPLOY_PATH = /usr/share/$${TARGET}

DISTFILES += qml/harbour-cpr-metronome.qml \
    icons/ \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/cpr-metronome.changes.in \
    rpm/cpr-metronome.changes.run.in \
    rpm/cpr-metronome.spec \
    rpm/harbour-cpr-metronome.spec \
    translations/*.ts \
    sounds/*.wav \
    harbour-cpr-metronome.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
# TRANSLATIONS += translations/cpr-metronome-de.ts

sounds.files = sounds/*.wav
sounds.path = $${DEPLOY_PATH}/sounds/
myicons.files = icons/*
myicons.path = /usr/share/icons/hicolor/

INSTALLS += \
    sounds \
    myicons
