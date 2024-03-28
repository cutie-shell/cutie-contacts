import Cutie
import Cutie.Wlc
import QtQuick

CutieWindow {
	id: mainWindow
	width: 400
	height: 800
	visible: true
	title: qsTr("Contacts")

	CutieWlc {
        id: compositor
    }

	CutieStore {
		id: contactStore
		appName: "cutie-contacts"
		storeName: "contacts"
	}

	initialPage: CutiePage {
		width: mainWindow.width
		height: mainWindow.height
		CutieListView {
			id: lView
			anchors.fill: parent
			model: contactStore.data.contacts

			header: CutiePageHeader {
				title: mainWindow.title
			}

			menu: CutieMenu {
				CutieMenuItem {
					text: qsTr("New Contact")
					onTriggered: {
						pageStack.push("qrc:/Edit.qml", {})
					}
				}
			}

			delegate: CutieListItem {
				width: parent ? parent.width : 0
				id: litem
				text: modelData.FirstName + " " + modelData.LastName
				onClicked: {
					mainWindow.pageStack.push("qrc:/Contact.qml", {contactId: index});
				}

				menu: CutieMenu {
					CutieMenuItem {
						text: qsTr("Edit")
						onTriggered: {
							mainWindow.pageStack.push("qrc:/Edit.qml", {contactId: index});
						}
					}
					CutieMenuItem {
						text: qsTr("Delete")
						onTriggered: {
							let data = contactStore.data;
							data.contacts.splice(index, 1);
							contactStore.data = data;
						}
					}
				}
			}
		}	
	}
}
