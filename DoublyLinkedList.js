class DoublyLinkedListNode {
	constructor (data, prev, next) {
		this._data = data;
		this.prev = prev || null;
		this.next = next || null;
		prev ? this.prev = prev : this._nodeCount--;
		next ? this.next = next : this._nodeCount--;
	}

	getData () {
		return this._data;
	}

	setData (newData) {
		this._data = newData;
	}
}

class DoublyLinkedList {
	constructor (head, tail) {
		this.head, this.tail = null, null;
		this._nodeCount = 2;
		head ? this.head = head : this._nodeCount--;
		tail ? this.tail = tail : this._nodeCount--;
	}

	appendNode (prevNode, appendedNode) {
		if(prevNode === this.tail) this.tail = appendedNode;
		appendedNode.next = prevNode.next;
		appendedNode.prev = prevNode;
		this._nodeCount++;

		return appendedNode;
	}

	insertNode (nextNode, insertedNode) {
		if(nextNode === this.head) this.head = insertedNode;
		insertedNode.prev = nextNode.prev;
		insertedNode.next = nextNode;
		this._nodeCount++;

		return insertedNode;
	}

	nodeCount () {
		return this._nodeCount;
	}

	pop () {
		let previousHead = this.head;
		this.head.next.prev = null;
		this.head = this.head.next;
		previousHead.next = null;
		this._nodeCount--;

		return previousHead;
	}

	push (newNode) {
		this.head.prev = newNode;
		newNode.next = this.head;
		this.head = newNode;
		this._nodeCount++;

		return newNode;
	}

	removeNode (node) {
		node.prev.next = node.next;
		node.next.prev = node.prev;
		node.next, node.prev = null, null;

		return node;
	}

	unshift (newNode) {
		this.tail.next = newNode;
		newNode.prev = this.tail;
		this.tail = newNode;
		this._nodeCount++;

		return newNode;
	}

	shift () {
		let previousTail = this.tail;
		this.tail.prev.next = null;
		this.tail = this.tail.prev;
		previousTail.prev = null;
		this._nodeCount--;
		
		return previousTail;
	}
}

module.exports = {
	DoublyLinkedListNode: DoublyLinkedListNode,
	DoublyLinkedList: DoublyLinkedList
}
