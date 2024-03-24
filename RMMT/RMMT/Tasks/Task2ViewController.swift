//
//  Task2ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 24.03.24.
//

import UIKit

final class Task2ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Task 1 is finished")

//        1
//        DispatchQueue.global().async {
//            for i in 0..<50 {
//                print(i)
//            }
//            print("Task 2 is finished")
//            print(Thread.current)
//        }

//        2
        Task.detached(priority: .userInitiated) {
            for i in 0..<50 {
                print(i)
            }
            print("Task 2 is finished")
            print(Thread.current)
        }

        print("Task 3 is finished")

        /*
         1. Ожидаемый вывод с DispatchQueue.global().async: task1, task3, task2 + thread != main. +

         2. Task.detached выделяет задачу из текущего контекста, ожидаю аналогичный результат. +

         3. После выставления приоритета думаю вывод может частично поменяться.
         Возможно task3 принт выведется где-то между принтов чисел.
         Таска будет выполняться в отдельном контексте с высоким приоритетом,
         относительно мейн треда, выполнение будет параллельным.
         UPD: Вывод остался налогичным. Но если перед task3 поставить sleep,
         мы убедимся, что task2 не ждет task3
         */
    }
}
