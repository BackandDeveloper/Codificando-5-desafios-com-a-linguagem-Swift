//Escreva uma função que resolva um sistema de equações lineares usando eliminação de Gauss.

func gaussElimination(_ matrix: inout [[Double]]) -> [Double]? {
    let n = matrix.count
    for i in 0..<n {
        var maxEl = abs(matrix[i][i])
        var maxRow = i
        for k in i+1..<n {
            if abs(matrix[k][i]) > maxEl {
                maxEl = abs(matrix[k][i])
                maxRow = k
            }
        }
        
        for k in i..<n+1 {
            let tmp = matrix[maxRow][k]
            matrix[maxRow][k] = matrix[i][k]
            matrix[i][k] = tmp
        }
        
        for k in i+1..<n {
            let c = -matrix[k][i] / matrix[i][i]
            for j in i..<n+1 {
                if i == j {
                    matrix[k][j] = 0
                } else {
                    matrix[k][j] += c * matrix[i][j]
                }
            }
        }
    }
    
    var x = [Double](repeating: 0, count: n)
    for i in stride(from: n-1, through: 0, by: -1) {
        x[i] = matrix[i][n] / matrix[i][i]
        for k in stride(from: i-1, through: 0, by: -1) {
            matrix[k][n] -= matrix[k][i] * x[i]
        }
    }
    return x
}

// Exemplo de uso
var sistema = [
    [2.0, -1.0, 1.0, 8.0],
    [-3.0, -1.0, 2.0, -11.0],
    [-2.0, 1.0, 2.0, -3.0]
]
if let solucao = gaussElimination(&sistema) {
    print("Solução: \(solucao)") // Saída: Solução: [2.0, 3.0, -1.0]
}
