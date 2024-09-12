import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0

import Nemo.KeepAlive 1.2

Page {
    id: cpr_metronome

    allowedOrientations: Orientation.Portrait

    property int currentBeat: 0
    property int elapsed_time: 0
    property int bpm: 110
    property int beat_duration: 60000 / bpm

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            metronomeTimer.running = true
        }
    }

    function formatTime(milliseconds) {
        var dateTime = new Date()
        dateTime.setMinutes(0)
        dateTime.setHours(0)
        dateTime.setSeconds(0)
        dateTime.setMilliseconds(milliseconds)

        return Qt.formatDateTime(dateTime, "hh:mm:ss")
    }


    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height

        Audio{ id: audio } // Using system volume

        SoundEffect{
            id: bip
            source: "../../sounds/bip.wav"
            volume: audio.volume
        }

        SoundEffect {
            id: bop
            source: "../../sounds/bop.wav"
            volume: audio.volume
        }

        Timer {
            id: metronomeTimer
            interval: 5
            repeat: true

            onTriggered: {
                elapsed_time += interval

                if ((elapsed_time % beat_duration) === 0) {
                    //currentBeat = (currentBeat + 1)%(bpm / 10) For 10 breath per minute
                    currentBeat = (currentBeat + 1) % bpm

                    if(currentBeat === 0) {
                        bip.play()
                        return
                    }
                    bop.play()
                }
            }
        }

        Column {
            id: column

            width: cpr_metronome.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("CPR Metronome")
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: formatTime(elapsed_time)
                font.pixelSize: Theme.fontSizeHuge * 2
            }
            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("Start Compressions!")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Rectangle {
                width: parent.width
                height: Theme.itemSizeMedium * 1.2

                color: "darkorange"

                Label {
                    id: help_toggle_text

                    anchors.centerIn: parent

                    text: "📱 Call for Help!"
                    font.pixelSize: Theme.fontSizeExtraLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        help_toggle_text.text = "Help called.\n" + formatTime(elapsed_time);
                        parent.color = "green";
                        enabled = false;
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: Theme.itemSizeMedium

                color: "darkorange"

                Label {
                    id: aed_toggle_text

                    anchors.centerIn: parent

                    text: "Send someone to get an AED!"
                    font.pixelSize: Theme.fontSizeLarge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        aed_toggle_text.text = "AED connected.\n" + formatTime(elapsed_time);
                        parent.color = "green";
                        enabled = false;
                    }
                }
            }
        }
    }
}
