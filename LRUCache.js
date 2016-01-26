import * from './DoublyLinkedList'

class LRUCache {
	constructor(maxSize) {
		this._maxSize = maxSize;
		this._memoryStore = {};
		this._list = new DoublyLinkedList():
	}

	_getNode (nodeID, fetchCallbackForMissingData) {
		let returnNode = null;

		if(this._memoryStore[id]) {
			returnNode = this._list.removeNode(this._memoryStore[nodeID]);
			this._list.push(returnNode);
		} else if(fetchCallbackForMissingData) {
			let data = fetchCallbackForMissingData(id);

			if(data) {
				returnNode = new DoublyLinkedListNode(data);
				while(this.size() >= this._maxSize) this._list.shift();

				this._list.push(returnNode);
			}	
		}

		return returnNode;
	}

	get (nodeID, fetchCallbackForMissingData) {
		let returnNode = this._getNode(nodeID, fetchCallbackForMissingData);

		return (returnNode ? returnNode.getData() : null);
	}

	maxSize () {
		return this._maxSize;
	}

	set (nodeID, data) {
		let node = this._getNode(nodeID);
		if(node) {
			node.setData(data);
		} else {
			node = this._memoryStore[nodeID] = new DoublyLinkedListNode(data);
			this._list.push(node);
		}

		return node;
	}

	size () {
		return this._list.nodeCount();
	}
}
