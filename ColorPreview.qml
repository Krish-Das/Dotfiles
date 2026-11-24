import Quickshell
import QtQuick
import "colors" as Palette

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
    }

    margins {
        top: 16
        left: 16
    }

    implicitWidth: 420
    implicitHeight: 440

    color: "transparent"
    aboveWindows: true
    focusable: false
    exclusiveZone: 0

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: Palette.Mocha.base
        border.color: Palette.Mocha.surface1
        border.width: 1

        Flickable {
            id: contentFlickable
            anchors.fill: parent
            anchors.margins: 18
            contentWidth: contentColumn.width
            contentHeight: contentColumn.height
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: contentColumn
                width: contentFlickable.width
                spacing: 14

                // Header
                Row {
                    width: parent.width
                    spacing: 10

                    Rectangle {
                        width: 4
                        height: 36
                        radius: 2
                        color: Palette.Mocha.mauve
                    }

                    Column {
                        spacing: 3

                        Text {
                            text: "MOCHA"
                            color: Palette.Mocha.text
                            font.pixelSize: 16
                            font.bold: true
                            font.letterSpacing: 2
                        }

                        Text {
                            text: "COLOR PALETTE PREVIEW"
                            color: Palette.Mocha.subtext0
                            font.pixelSize: 9
                            font.letterSpacing: 1.5
                        }
                    }

                    Item {
                        width: 1
                        height: 1
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Palette.Mocha.surface0
                }

                // Accent colors
                Text {
                    text: "ACCENTS"
                    color: Palette.Mocha.subtext1
                    font.pixelSize: 10
                    font.bold: true
                    font.letterSpacing: 1.5
                }

                Grid {
                    width: parent.width
                    columns: 4
                    spacing: 8

                    Repeater {
                        model: [
                            { name: "rosewater", color: Palette.Mocha.rosewater },
                            { name: "flamingo",  color: Palette.Mocha.flamingo },
                            { name: "pink",      color: Palette.Mocha.pink },
                            { name: "mauve",     color: Palette.Mocha.mauve },
                            { name: "red",       color: Palette.Mocha.red },
                            { name: "peach",     color: Palette.Mocha.peach },
                            { name: "yellow",    color: Palette.Mocha.yellow },
                            { name: "green",     color: Palette.Mocha.green },
                            { name: "teal",      color: Palette.Mocha.teal },
                            { name: "blue",      color: Palette.Mocha.blue }
                        ]

                        delegate: Rectangle {
                            width: 85
                            height: 48
                            radius: 7
                            color: Palette.Mocha.mantle
                            border.color: Palette.Mocha.surface0
                            border.width: 1

                            Column {
                                anchors.centerIn: parent
                                spacing: 5

                                Rectangle {
                                    width: 64
                                    height: 12
                                    radius: 3
                                    color: modelData.color
                                }

                                Text {
                                    width: 70
                                    text: modelData.name
                                    color: Palette.Mocha.subtext1
                                    font.pixelSize: 9
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Palette.Mocha.surface0
                }

                // Text colors
                Text {
                    text: "TYPOGRAPHY"
                    color: Palette.Mocha.subtext1
                    font.pixelSize: 10
                    font.bold: true
                    font.letterSpacing: 1.5
                }

                Rectangle {
                    width: parent.width
                    height: 48
                    radius: 7
                    color: Palette.Mocha.mantle

                    Row {
                        anchors.centerIn: parent
                        spacing: 18

                        Text {
                            text: "Text"
                            color: Palette.Mocha.text
                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            text: "Subtext 1"
                            color: Palette.Mocha.subtext1
                            font.pixelSize: 12
                        }

                        Text {
                            text: "Subtext 0"
                            color: Palette.Mocha.subtext0
                            font.pixelSize: 11
                        }
                    }
                }

                // Surface colors
                Text {
                    text: "SURFACES"
                    color: Palette.Mocha.subtext1
                    font.pixelSize: 10
                    font.bold: true
                    font.letterSpacing: 1.5
                }

                Row {
                    width: parent.width
                    spacing: 8

                    Repeater {
                        model: [
                            { name: "surface0", color: Palette.Mocha.surface0 },
                            { name: "surface1", color: Palette.Mocha.surface1 },
                            { name: "surface2", color: Palette.Mocha.surface2 },
                            { name: "base", color: Palette.Mocha.base },
                            { name: "mantle", color: Palette.Mocha.mantle },
                            { name: "crust", color: Palette.Mocha.crust }
                        ]

                        delegate: Rectangle {
                            width: 53
                            height: 55
                            radius: 6
                            color: modelData.color
                            border.color: Palette.Mocha.surface2
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                rotation: -90
                                text: modelData.name
                                color: Palette.Mocha.text
                                font.pixelSize: 8
                            }
                        }
                    }
                }

                Item {
                    width: 1
                    height: 1
                }

                // Footer
                Row {
                    width: parent.width
                    spacing: 6

                    Rectangle {
                        width: 6
                        height: 6
                        radius: 3
                        color: Palette.Mocha.green
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: "20 COLORS  /  CATPPUCCIN MOCHA"
                        color: Palette.Mocha.subtext0
                        font.pixelSize: 9
                        font.letterSpacing: 1
                    }
                }
            }
        }
    }
}
