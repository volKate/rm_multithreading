import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(2)
        DispatchQueue.main.async {
            print(3)
            DispatchQueue.main.sync {
                print(5)
            }
            print(4)
        }
        print(6)
    }
}

let vc = ViewController()
print(1)
let view = vc.view
print(7)

/*
 запринтится  1 2 6 7 3, а затем произойдет deadlock
 1 2 6 7 принтятся синхронно
 затем на той же главное очереди отрабатывает асинхронная задача 3,
 а потом из-за синхронного вызова main,
 происходит deadlock
 */
