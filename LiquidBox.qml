import QtQuick 2.0
 import QtQuick.Controls 2.2

Rectangle {
    id: root
    width: 200
    height: 200

    property bool isInput: true
    property alias temperature: temperatureSb.value
    property alias mass: massSb.value

    signal liquidChanged


    Text {
        id: temperatureTxt
        text: "Temperature"

        anchors {top: parent.top; left: parent.left; right: parent.right }
        height: parent.height /6

        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter;
    }

    SpinBox {
        id: temperatureSb

        anchors {top: temperatureTxt.bottom; left: parent.left; right: parent.right }
        height: parent.height /3

        value: 50

        editable: isInput
        enabled: isInput

        from: 0
        to: 100

        onValueChanged: { console.log("changed"); liquidChanged() }
        onValueModified: { console.log("modified"); liquidChanged() }
    }

    Text {
        id: massTxt
        text: "Amount"

        anchors {top: temperatureSb.bottom; left: parent.left; right: parent.right }
        height: parent.height /6

        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter;
    }

    SpinBox {
        id: massSb

        anchors {top: massTxt.bottom; left: parent.left; right: parent.right }
        height: parent.height /3

        value: 125

        editable: isInput
        enabled: isInput

        from: 0
        to: 100000

        onValueChanged: { console.log("changed"); liquidChanged() }
        onValueModified: { console.log("modified"); liquidChanged() }
    }

}
