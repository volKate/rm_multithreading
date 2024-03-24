//
//  Task1ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 18.03.24.
//

import UIKit

final class Task1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            print(1)
            //        1
            //        DispatchQueue.main.async {
            //            print(2)
            //        }
            
            //        2
            //        Task {
            //            print(2)
            //        }
            
            //        3
            Task { @MainActor in
                print(2)
            }
            print(3)
        }
    }

    /*
     Вывод: 1 3 2. 1 и 3 выводятся синхронно на главном потоке,
     затем 2 асинхронно на том же потоке.

     Я ожидала: 1 2 3, но вывод: 1 3 2. В playground при этом вывод 1 2 3.
     Task вызывает асинхронно задачу. Видимо в зависимости от того, в каком контексте задача,
     может немного меняться вывод. В playground Thread.current сторонний поток,
     поэтому задача выполняется асинхронно и выполняется довольно быстро.
     Тут Thread.current выводит main, получается вывод совпадает с DispatchQueue.main.async.

     Вывод: 1 3 2. Ничего не изменилось, но в plyground бы изменилось.
     @MainActor атрибут заставляет задачи выполняться на главном потоке.
     Поэтому мы опять получаем поведение аналогичное DispatchQueue.main.async.
     */
}

