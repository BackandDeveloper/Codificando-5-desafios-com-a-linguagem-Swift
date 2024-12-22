//Complemente um sistema de cache LRU (Least Recently Used) usando um dicionário e uma lista duplamente ligada.


class Node<Key, Value> {
    var key: Key
    var value: Value
    var prev: Node?
    var next: Node?
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
}

class LRUCache<Key: Hashable, Value> {
    private var capacity: Int
    private var dict: [Key: Node<Key, Value>] = [:]
    private var head: Node<Key, Value>?
    private var tail: Node<Key, Value>?
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Key) -> Value? {
        guard let node = dict[key] else { return nil }
        moveToHead(node)
        return node.value
    }
    
    func put(_ key: Key, value: Value) {
        if let node = dict[key] {
            node.value = value
            moveToHead(node)
        } else {
            let newNode = Node(key: key, value: value)
            if dict.count == capacity {
                removeTail()
            }
            addToHead(newNode)
            dict[key] = newNode
        }
    }
    
    private func moveToHead(_ node: Node<Key, Value>) {
        removeNode(node)
        addToHead(node)
    }
    
    private func removeNode(_ node: Node<Key, Value>) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        if node === head { head = node.next }
        if node === tail { tail = node.prev }
    }
    
    private func addToHead(_ node: Node<Key, Value>) {
        node.next = head
        node.prev = nil
        head?.prev = node
        head = node
        if tail == nil { tail = node }
    }
    
    private func removeTail() {
        guard let tail = tail else { return }
        removeNode(tail)
        dict[tail.key] = nil
    }
}

// Exemplo de uso
let cache = LRUCache<String, Int>(capacity: 2)
cache.put("a", value: 1)
cache.put("b", value: 2)
print(cache.get("a")) // Saída: Optional(1)
cache.put("c", value: 3)
print(cache.get("b")) // Saída: nil (removido por ser o menos recentemente usado)
