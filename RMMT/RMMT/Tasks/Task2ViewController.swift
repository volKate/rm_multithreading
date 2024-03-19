//
//  Task2ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 18.03.24.
//

import UIKit

final class Task2ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем и запускаем поток с таймером
        let timer = TimerThread(duration: 10)
        timer.start()
    }
}

final class TimerThread: Thread {
    private var timerDuration: Int
    private var timer: Timer!

    init(duration: Int) {
        self.timerDuration = duration
    }

    override func main() {
        // Создаем таймер, который будет выполняться каждую секунду
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

        print(Thread.current)

        // Добавляем таймер в текущий run loop ниже
        RunLoop.current.add(timer, forMode: .common)

        // Запускаем текущий run loop ниже
        RunLoop.current.run()
    }

    @objc func updateTimer() {
        // Ваш код здесь будет выполняться каждую секунду
        if timerDuration > 0 {
            print("Осталось \(timerDuration) секунд...")
            timerDuration -= 1
        } else {
            print("Время истекло!")

            timer.invalidate()
            // Остановка текущего run loop после завершения таймера
            CFRunLoopStop(CFRunLoopGetCurrent())
        }
    }
}
