//
//  Task4ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 19.03.24.
//

import UIKit

final class Task4ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем и запускаем поток
        let demonThread = ThreadprintDemon()
        let angelThread = ThreadprintAngel()


        // Меняем приоритеты сначала 2 потом 1
//        demonThread.qualityOfService = .background
//        angelThread.qualityOfService = .userInitiated
//
        // Меняем приоритеты сначала 1 потом 2
//        demonThread.qualityOfService = .userInitiated
//        angelThread.qualityOfService = .utility

        // Меняем приоритеты вперемешку
        demonThread.qualityOfService = .utility
        angelThread.qualityOfService = .utility

        demonThread.start()
        angelThread.start()
    }
}

final class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            print("1")
        }
    }
}
final class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            print("2")
        }
    }
}
