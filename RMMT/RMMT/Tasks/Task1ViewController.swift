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
        for _ in (0..<10) {
            let currentThread = Thread.current
            print("1, Current thread: \(currentThread)")
        }

        /*
         detachNewThread перенесет выполнение второго цикла в отдельный поток
         Мы увидим в консоли информацию о другом потоке,
         отличном от main.
         Далее в зависимости уже от системы, мы можем получать "рандомный"
         вывод принтов в консоль. Потоки будут выполняться параллельно.
         Это также значит, что выводы могут быть "перемешаны" по мере выполнения
         то одного, то второго.
         */
        Thread.detachNewThread {
            for _ in (0..<10) {
                let currentThread = Thread.current
                print("2, Current thread: \(currentThread)")
            }
        }
    }
    /// Только первый цикл перевести в другой поток с помощью Thread.detachNewThread и обяснить почему изменился вывод.
}
