//
//  Task7ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 22.03.24.
//

import UIKit

final class Task7ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Использование
        /*
         тут у нас проблема race condition
         наш threadSafeSarray на самом деле совсем не сейф
         Можно решить проблему несколькими путями:
         1 добавить зависимости между операциями
         2 можно превратить ThreadSafeArray в актора обеспечивая потокобезопасность
         3 можно поставить лок или семафор на запись array
         */
        let threadSafeArray = ThreadSafeArray()
        let operationQueue = OperationQueue()
        
        let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
        let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)

        // 1 решение
//        secondOperation.addDependency(firstOperation)

        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)
        
        // Дождитесь завершения операций перед выводом содержимого массива
        operationQueue.waitUntilAllOperationsAreFinished()
        
        Task {
            await print(threadSafeArray.getAll())
        }
    }
    
    
}

// Объявляем класс для для синхронизации потоков
//class ThreadSafeArray {
//    private let lock = NSLock()
//    private var array: [String] = []
//    
//    func append(_ item: String) {
//        // 2 решение. Но в данном случае последовательность не гарантирована
//        // но запись потокобезопасна
//        lock.lock()
//        array.append(item)
//        lock.unlock()
//    }
//    
//    func getAll() -> [String] {
//        return array
//    }
//}

// 3 решение.
actor ThreadSafeArray {
    private var array: [String] = []

    func append(_ item: String) async {
        array.append(item)
    }

    func getAll() async -> [String] {
        return array
    }
}

// Определяем первую операцию для добавления строки в массив
class FirstOperation: Operation {
    let threadSafeArray: ThreadSafeArray
    
    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }
    
    override func main() {
        if isCancelled { return }
        Task {
            await threadSafeArray.append("Первая операция")
        }
    }
}

// Определяем вторую операцию для добавления строки в массив
class SecondOperation: Operation {
    let threadSafeArray: ThreadSafeArray

    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }

    override func main() {
        if isCancelled { return }
        Task {
            await threadSafeArray.append("Вторая операция")
        }
    }
}
