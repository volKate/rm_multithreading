//
//  Task5ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 19.03.24.
//

import UIKit

final class Task5ViewController: UIViewController {
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
    private var name = "Введите имя"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateName()
    }

    func updateName() {
        /*
         В случае async наша main очередь не ждет конца выполнения
         задачи в другом потоке и продолжает выполнять свои задачи
         Вывод: Введите имя, I love RM

         В случае sync main очередь блокируется на время выполнения
         задачи в другом потоке
         Вывод: I love RM, I love RM
         */


        lockQueue.sync {
            self.name = "I love RM" // Перезаписываем имя в другом потоке
            print(Thread.current)
            print(self.name)
        }

        print(self.name) // Считываем имя из main

        /*
         WARNING: ThreadSanitizer: data race
         Thread Sanitizer видит проблему race condition,
         что мы из разных поток пытаемся писать и читать
         одну переменную в одно время.
         */
    }
}
