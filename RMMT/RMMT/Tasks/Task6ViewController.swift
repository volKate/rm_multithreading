//
//  Task6ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 22.03.24.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Метод для запуска операции
    func start()
}

protocol RMOperationQueueProtocol {
    var operations: [RMOperation] { get }
    func addOperation(_ operation: RMOperation)
    func executeNextOperation()
}

final class RMOperationQueue: RMOperationQueueProtocol {
    var operations: [RMOperation] = []
    private let semaphore = DispatchSemaphore(value: 1)

    func addOperation(_ operation: RMOperation) {
        operations.append(operation)
        executeNextOperation()
    }

    func executeNextOperation() {
        semaphore.wait()
        let nextOperation = operations.first(where: { !$0.isExecuting && !$0.isFinished })
        semaphore.signal()
        if let nextOperation = nextOperation {
            nextOperation.start()
//            executeNextOperation()
        }

    }

}

class RMOperation: RMOperationProtocol {
    var priority: DispatchQoS.QoSClass = .unspecified

    var completionBlock: (() -> Void)?
    
    var isFinished: Bool = false
    var isExecuting: Bool = false

    private let semaphore = DispatchSemaphore(value: 1)

    /// В методе start. реализуйте все через глобальную паралельную очередь с приоритетами.
    func start() {
        // Создаю задачу на выполнение операции
        let workItem = DispatchWorkItem {
            self.semaphore.wait()
            self.isExecuting = true
            self.semaphore.signal()
            print("doing operation with priority: \(self.priority)")
        }
        // Подписываюсь на завершение задачи
        workItem.notify(queue: DispatchQueue.global()) {
            // По завершению выставляю флаг и вызываю completionBlock
            self.semaphore.wait()
            self.isExecuting = false
            self.isFinished = true
            self.semaphore.signal()
            self.completionBlock?()
        }
        // На concurrent очереди с приоритетов запускаю выполнение задачи
        DispatchQueue.global(qos: priority).async(execute: workItem)
    }
}

final class Task6ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rmOperationQueue = RMOperationQueue()

        let operationFirst = RMOperation()
        let operationSecond = RMOperation()

        operationFirst.priority = .background
        operationFirst.completionBlock = {
            print(1)
        }

        operationSecond.priority = .userInteractive
        operationSecond.completionBlock = {
            print(2)
        }

        rmOperationQueue.addOperation(operationFirst)
        rmOperationQueue.addOperation(operationSecond)

        
//        operationFirst.priority = .userInitiated
//        operationFirst.completionBlock = {
//            
//            for _ in 0..<50 {
//                print(2)
//            }
//            print(Thread.current)
//            print("Операция полностью завершена!")
//        }
        
//        operationFirst.start()
        
        
        
//        operationSecond.priority = .background
//        operationSecond.completionBlock = {
//            
//            for _ in 0..<50 {
//                print(1)
//            }
//            print(Thread.current)
//            print("Операция полностью завершена!")
//        }
//        operationSecond.start()
        
    }
}
