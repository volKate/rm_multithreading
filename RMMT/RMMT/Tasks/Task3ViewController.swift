//
//  Task3ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 19.03.24.
//

import UIKit

final class Task3ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        print(infinityThread.isExecuting) // false
        print(infinityThread.isFinished) // false
        infinityThread.start()
        // сразу после старта isExecuting=false, потоку надо немного времени видимо,
        // чтобы стартануть

        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(5)
        print(infinityThread.isExecuting) // true
        // Отменяем тут
        infinityThread.cancel()

        // тут аналогично, поток останавливаетс не мгновенно
        sleep(2)
        print(infinityThread.isExecuting) // false
        print(infinityThread.isFinished) // true
    }
}

final class InfinityLoop: Thread {
    var counter = 0

    override func main() {
        while counter < 30 && !isCancelled {
            counter += 1
            print(counter)
            InfinityLoop.sleep(forTimeInterval: 1)
        }
    }
}
