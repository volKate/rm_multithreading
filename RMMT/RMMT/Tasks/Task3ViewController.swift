//
//  Task3ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 20.03.24.
//

import UIKit
import Foundation

final class Task3ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //        problem1()
        //        problem2()
                problem3()
//        problem4()
    }

    private func problem1() {
        let serialQueue = DispatchQueue(label: "com.example.myQueue")

        /*
         deadlock
         синхронный вызов себя же на серийной очереди
         заставляет очередь ждать саму себя вызывая deadlock.
         */
        serialQueue.async {
            serialQueue.async {
                print("This will never be printed.")
            }
        }
    }

    private func problem2() {
        var sharedResource = 0

        /*
         race condition
         Проблема одновременного доступа к одному ресурсу
         из разных потоков
         */
        /*
         можно решить с помощью NSLock, DispatchSemaphore, Actor
         */
        let lock = NSLock()
        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                lock.lock()
                sharedResource += 1
                print("1", sharedResource)
                lock.unlock()
            }
        }

        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                lock.lock()
                sharedResource += 1
                print("2", sharedResource)
                lock.unlock()
            }
        }
    }

    private func problem3() {
        /*
         liveLock
         Активная блокировка потоками друг друга
         */
        let people1 = People1()
        let people2 = People2()

        let thread1 = Thread {
            people1.walkPast(with: people2)
        }
        thread1.start()

        let thread2 = Thread {
            people2.walkPast(with: people1)
        }

        thread2.start()

        sleep(2)
        thread2.cancel()
    }

    private func problem4() {
        /*
         priority inversion
         Проблема при которой менее приоритетный поток
         захватывает ресурс и более приоритетный ресурс
         становится на паузу в ожидани этого ресурса.
         В этот момент реальное состояние потоков
         противоречий ожидаемому.
         */
        DispatchQueue.global().async {
            self.thread1()
        }

        DispatchQueue.global().async {
            self.thread2()
        }
    }

    let resourceASemaphore = DispatchSemaphore(value: 1)
    let resourceBSemaphore = DispatchSemaphore(value: 1)

    func thread1() {
        print("Поток 1 пытается захватить Ресурс A")
        resourceASemaphore.wait() // Захват Ресурса A

        print("Поток 1 захватил Ресурс A и пытается захватить Ресурс B")
        Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock

        resourceBSemaphore.wait() // Попытка захвата Ресурса B, который уже занят Потоком 2
        print("Поток 1 захватил Ресурс B")

        //resourceBSemaphore.signal()
        resourceASemaphore.signal()
    }

    func thread2() {
        print("Поток 2 пытается захватить Ресурс B")
        resourceBSemaphore.wait() // Захват Ресурса B

        print("Поток 2 захватил Ресурс B и пытается захватить Ресурс A")
        Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock

        // resourceASemaphore.wait() // Попытка захвата Ресурса A, который уже занят Потоком 1
        print("Поток 2 захватил Ресурс A")

        //resourceASemaphore.signal()
        resourceBSemaphore.signal()
    }
}

class People1 {
    let lock = NSLock()
    var isDifferentDirections = false

    func walkPast(with people: People2) {
        while (!people.isDifferentDirections) {
            print("People1 не может обойти People2")
            sleep(1)
        }

        print("People1 смог пройти прямо")
        lock.lock()
        isDifferentDirections = true
        lock.unlock()
    }
}

class People2 {
    let lock = NSLock()
    var isDifferentDirections = false

    func walkPast(with people: People1) {
        while (!people.isDifferentDirections && !Thread.current.isCancelled) {
            print("People2 не может обойти People1")
            sleep(1)
        }

        print("People2 смог пройти прямо")
        // Заблокируем доступ к переменной,
        // чтобы другой поток не мог ее прочитать прежде, чем мы перезапишем
        lock.lock()
        isDifferentDirections = true
        lock.unlock()
    }
}


