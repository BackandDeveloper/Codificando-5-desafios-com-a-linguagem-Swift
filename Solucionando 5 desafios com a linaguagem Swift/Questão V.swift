//Implemente um algoritmo de busca A (A-star) para encontrar o caminho mais curto em um grafo.*

class Node: Hashable {
    var position: (Int, Int)
    var g: Double
    var h: Double
    var f: Double { return g + h }
    var parent: Node?
    
    init(position: (Int, Int), g: Double, h: Double, parent: Node? = nil) {
        self.position = position
        self.g = g
        self.h = h
        self.parent = parent
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.position == rhs.position
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position.0)
        hasher.combine(position.1)
    }
}

func aStar(start: (Int, Int), goal: (Int, Int), grid: [[Int]]) -> [(Int, Int)]? {
    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    var openSet: Set<Node> = [Node(position: start, g: 0, h: heuristic(start, goal))]
    var closedSet: Set<Node> = []
    
    while let current = openSet.min(by: { $0.f < $1.f }) {
        if current.position == goal {
            return reconstructPath(current)
        }
        
        openSet.remove(current)
        closedSet.insert(current)
        
        for direction in directions {
            let neighborPos = (current.position.0 + direction.0, current.position.1 + direction.1)
            guard isValid(neighborPos, in: grid) else {[_{{{CITATION{{{_1{](https://github.com/swiftdo/swiftdo/tree/137833b8dbddaa691d1ba2eab7e3570702838666/docs%2Fbasis%2Falgorithms%2Ft5-quick-sort.md)