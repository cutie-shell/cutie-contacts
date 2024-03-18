import Cutie
import QtQuick

CutiePage {
	width: mainWindow.width
	height: mainWindow.height
	property var contactId: null

	ListModel {
		id: dataModel
		ListElement {
			name: qsTr("First name")
			value: "FirstName"
		}
		ListElement {
			name: qsTr("Last name")
			value: "LastName"
		}
		ListElement {
			name: qsTr("Phone number")
			value: "PhoneNumber"
			imHints: Qt.ImhDialableCharactersOnly
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
		id: editLView
		anchors.fill: parent
		model: dataModel

		header: CutiePageHeader {
			title: qsTr("Edit contact")
		}

		delegate: Item {
			width: parent.width
			height: delCol.height

			property alias text: editField.text

			Column {
				id: delCol
				x: 20
				width: parent.width - 40
				padding: 15

				CutieLabel {
					text: name
					anchors {
						left: parent.left
						right: parent.right
					}
				}

				CutieTextField {
					id: editField
					text: contactId === null ? "" :
						contactStore.data.contacts[contactId][value]
					inputMethodHints: imHints
					anchors {
						left: parent.left
						right: parent.right
					}
				}
			}
		}

		footer: Item {
			width: parent.width
			height: saveButton.height + 40

			CutieButton {
				id: saveButton
				text: qsTr("Save")
				anchors.fill: parent
				anchors.margins: 20

				onClicked: {
					let contact = {};
					for (let i = 0; i < dataModel.count; i++) {
						contact[dataModel.get(i).value]
							= editLView.itemAtIndex(i).text;
					}

					let data = contactStore.data;
					if (!data.contacts) data.contacts = [];
					if (contactId === null) data.contacts.push(contact);
					else data.contacts[contactId] = contact;
					contactStore.data = data;

					pageStack.pop();
				}
			}
		}
	}
}
