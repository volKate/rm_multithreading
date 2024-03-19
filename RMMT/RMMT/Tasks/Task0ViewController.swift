//
//  Task1ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 18.03.24.
//

import UIKit

final class Task0ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        runTask0()
    }

    private func runTask0() {
        print(Thread.current) // <_NSMainThread: 0x600001700040>{number = 1, name = main}
    }

    private func runExample1() {
        print("start test")
        for index in 0...UInt.max {
            /*
             Без autoreleasepool не смотря на то,
             что переменная теряет ссылку выходя из итерации for loop,
             счетчик ссылок обновится при ближайшем проходе run loop.
             Но он заблокирован выполнением все новых и новых задач.
             */
            autoreleasepool {
                let string = NSString(format: "test + %d", index)
                print(string)
            }
            /*
             Для объектов swift память и так высвободится
             let string = String(format: "test + %d", index)
             print(string)
             */
        }
        print("end test")
    }
}

