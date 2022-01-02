import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: window
    width: 300
    height: 300
    visible: true
    title: qsTr("Hello Arrow")

    Canvas {
        id: canvas

        anchors { top: titleTxt.bottom; bottom: infoTxt.top; left: parent.left; right: parent.right }

        function arrow(context, fromx, fromy, tox, toy) {
            const dx = tox - fromx;
            const dy = toy - fromy;
            const headlen = Math.sqrt(dx/4 * dx/4 + dy/4 * dy/4);
            const strokeWidth = headlen * 0.5;
            const angle = Math.atan2(dy, dx);

            const lineStartX = fromx + dx/4
            const lineStartY = fromy + dy/4

            const lineEndX = fromx + dx/2
            const lineEndY = fromy + dy/2

            const triangleEndX = fromx + dx/4*3
            const triangleEndY = fromy + dy/4*3

            const arrow1x = triangleEndX - headlen * Math.cos(angle - Math.PI / 6)
            const arrow1y = triangleEndY - headlen * Math.sin(angle - Math.PI / 6)
            const arrow2x = triangleEndX - headlen * Math.cos(angle + Math.PI / 6)
            const arrow2y = triangleEndY - headlen * Math.sin(angle + Math.PI / 6)


            context.lineWidth = strokeWidth;


            // triangle
            context.fillStyle = Qt.rgba(0.1, 0.1, 0.1, 1);
            context.beginPath();
            context.moveTo(arrow1x, arrow1y);
            context.lineTo(triangleEndX, triangleEndY );
            context.lineTo(arrow2x, arrow2y);
            context.closePath();
            context.fill();
            context.stroke();

            //line
            context.beginPath();
            context.moveTo(lineStartX, lineStartY);
            context.lineTo(lineEndX, lineEndY);
            context.stroke();
        }

        function drawArrows(ctx) {
            arrow(ctx, rect1.x+rect1.width/2 - canvas.x, rect1.y+rect1.height/2-canvas.y, rect3.x+rect3.width/2-canvas.x, rect3.y+rect3.height/2-canvas.y)
            arrow(ctx, rect2.x+rect2.width/2 - canvas.x, rect2.y+rect2.height/2-canvas.y, rect3.x+rect3.width/2-canvas.x, rect3.y+rect3.height/2-canvas.y)
        }

        onPaint: {
            // Get the canvas context
            var ctx = getContext("2d");
            // Fill a solid color rectangle
            ctx.fillStyle = Qt.rgba(0.1, 0.1, 0.8, 1);
            ctx.fillRect(0, 0, width, height);

            if (window.width < window.height * 1.2 && window.height < window.width * 1.2) {
                console.log("square")
            }
            else if (window.width < window.height) {
                console.log("portrait")
            }
            else if (window.width > window.height) {
                console.log("landscape")
            }
            drawArrows(ctx)
        }
    }


    function updateOutputLiquid() {
        rect3.mass = rect1.mass + rect2.mass
        rect3.temperature = (rect1.mass * rect1.temperature + rect2.mass * rect2.temperature) / rect3.mass
    }

    LiquidBox {
        id: rect1
        width: canvas.width /5
        height: canvas.height /5

        temperature: 21
        mass: 100

        anchors { left: canvas.left; leftMargin: width/2; top: canvas.top; topMargin: height/2 }

        onLiquidChanged: updateOutputLiquid()
    }

    LiquidBox {
        id: rect2
        width: canvas.width /5
        height: canvas.height /5

        temperature: 98
        mass: 100

        anchors { right: canvas.right; rightMargin: width/2; top: canvas.top; topMargin: height/2 }

        onLiquidChanged: updateOutputLiquid()

    }

    LiquidBox {
        id: rect3
        width: canvas.width /5
        height: canvas.height /5

        isInput: false

        anchors { horizontalCenter: canvas.horizontalCenter; bottom: canvas.bottom; bottomMargin: height/2 }


        Component.onCompleted: updateOutputLiquid()

    }



    property real menuDivider: 6

    Text {
        id: settingsTxt

        anchors { left: parent.left; top: parent.top; }
        width: parent.width /menuDivider; height: parent.height /menuDivider;

        text: "Settings"
        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter

        Rectangle { anchors.fill: parent; border.color: "green"; color: "transparent" }
    }

    Text {
        id: infoTxt

        anchors { left: parent.left; bottom: parent.bottom; }
        width: parent.width /menuDivider; height: parent.height /menuDivider;

        text: "Info"
        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter

        Rectangle { anchors.fill: parent; border.color: "green"; color: "transparent" }
    }

    Text {
        id: instructionsTxt

        anchors { right: parent.right; bottom: parent.bottom; }
        width: parent.width /menuDivider; height: parent.height /menuDivider;

        text: "Instructions"
        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter

        Rectangle { anchors.fill: parent; border.color: "green"; color: "transparent" }
    }

    Text {
        id: resetTxt

        anchors { right: parent.right; top: parent.top; }
        width: parent.width /menuDivider; height: parent.height /menuDivider;

        text: "Reset"
        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter

        Rectangle { anchors.fill: parent; border.color: "green"; color: "transparent" }
    }


    Text {
        id: titleTxt

        anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: parent.height /menuDivider }
        width: parent.width; height: parent.height /menuDivider;

        text: "Liquid Mixture Temperature Calculator"
        fontSizeMode: Text.Fit
        minimumPixelSize: 10
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter

        Rectangle { anchors.fill: parent; border.color: "green"; color: "transparent" }
    }


}
