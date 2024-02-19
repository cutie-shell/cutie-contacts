import Cutie
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

CutiePage {
	id: root

	property var contactId: null

	ListModel {
		id: dataModel
		ListElement {
			name: qsTr("Phone number")
			value: "PhoneNumber"
		}
		ListElement {
			name: qsTr("Email address")
			value: "EmailAddress"
		}
		ListElement {
			name: qsTr("Home address")
			value: "HomeAddress"
		}
	}

	CutieListView {
		anchors.fill: parent
		model: dataModel
	
		header: CutiePageHeader {
			title: root.contactId === null ? "" :
				contactStore.data.contacts[contactId].FirstName + " " +
				contactStore.data.contacts[contactId].LastName
		}

		menu: CutieMenu {
			CutieMenuItem {
				text: qsTr("Edit")
				onTriggered: {
					pageStack.push("qrc:/Edit.qml", { contactId })
				}
			}
			CutieMenuItem {
				text: qsTr("Delete")
				onTriggered: {
					if (contactId !== null) {
						let data = contactStore.data;
						data.contacts.splice(contactId, 1);
						contactStore.data = data;
					}

					pageStack.pop();
				}
			}
		}

		delegate: CutieListItem {
			text: contactStore.data.contacts[contactId][value]
			subText: name
		}
	}
}