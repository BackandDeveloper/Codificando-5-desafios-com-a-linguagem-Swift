//Implemente um algoritmo de ordenação rápida (QuickSort) genérico que funcione com qualquer tipo que seja comparável.

func quickSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    
    let pivot = array[array.count / 2]
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    
    return quickSort(less) + equal + quickSort(greater)
}

// Exemplo de uso
let numeros = [3, 6, 8, 10, 1, 2, 1]
print(quickSort(numeros)) // Saída: [1, 1, 2, 3, 6, 8, 10]
