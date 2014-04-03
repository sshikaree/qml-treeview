import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

Rectangle {
    width: 600
    height: 350
    ListView {
        anchors.fill: parent
        delegate: groupsDelegate
        model: listModel

        Component {
            id: groupsDelegate

            Item {
                width: 150
                height: mainRow.childrenRect.height

                RowLayout {
                    anchors.fill: parent
                    id: mainRow
                    property bool expanded: false
                    Column {
                        anchors.leftMargin: 10
                        id: mainColumn
                        Row {
                            spacing: 2
                            Image {
                                id: expander
                                source: "expander.png"
                                rotation: mainRow.expanded ? 90 : 0
                                opacity: elements.count === 0 ? 0 : 1
                                Behavior on rotation {
                                    NumberAnimation {duration: 110}
                                }

                                MouseArea {
                                    visible: expander.opacity === 1 ? true : false
                                    id: expanderMouseArea
                                    anchors.fill: parent
                                    onClicked: mainRow.expanded = !mainRow.expanded
                                }
                            }

                            Text {
                                id: name
                                text: group
                            }
                        }
                        ListView {
                            anchors.right: parent.right
                            visible: mainRow.expanded
                            model: elements
                            delegate: groupsDelegate
                        }
                    }

                    //                                        ListView {
                    //                                            anchors.right: parent.right
                    //                                            visible: mainRow.expanded
                    //                                            model: elements
                    //                                            delegate: groupsDelegate
                    //                                        }
                }
            }
        }

        ListModel {
            id:listModel
            ListElement {group: "first"; elements: []}
            ListElement {
                group: "second"
                elements: [
                    ListElement {
                        group: "second2"
                        elements: [
                            ListElement {
                                group: "second2.2"
                                elements: []
                            }
                        ]
                    },
                    ListElement {group: "second3"; elements: []}
                ]
            }
            ListElement {group: "third"; elements: []}
        }
    }


}
