//rie uma função que resolva o problema do caixeiro viajante usando força bruta.

func permutacoes<T>(_ array: [T]) -> [[T]] {
    if array.count == 0 { return [[]] }
    return array.indices.flatMap { i -> [[T]] in
        var rest = array
        let elem = rest.remove(at: i)
        return permutacoes(rest).map { [elem] + $0 }
    }
}

func distancia(_ a: (Double, Double), _ b: (Double, Double)) -> Double {
    return sqrt(pow(a.0 - b.0, 2) + pow(a.1 - b.1, 2))
}

func caixeiroViajante(_ cidades: [(Double, Double)]) -> (caminho: [(Double, Double)], distancia: Double) {
    let todosCaminhos = permutacoes(cidades)
    var menorDistancia = Double.infinity
    var melhorCaminho: [(Double, Double)] = []
    
    for caminho in todosCaminhos {
        var distanciaTotal = 0.0
        for i in 0..<caminho.count - 1 {
            distanciaTotal += distancia(caminho[i], caminho[i + 1])
        }
        distanciaTotal += distancia(caminho.last!, caminho.first!)
        
        if distanciaTotal < menorDistancia {
            menorDistancia = distanciaTotal
            melhorCaminho = caminho
        }
    }
    
    return (melhorCaminho, menorDistancia)
}

// Exemplo de uso
let cidades = [(0.0, 0.0), (1.0, 1.0), (2.0, 2.0), (3.0, 3.0)]
let resultado = caixeiroViajante(cidades)
print("Melhor caminho: \(resultado.caminho), Distância: \(resultado.distancia)")
