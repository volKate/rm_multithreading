//
//  Task5ViewController.swift
//  RMMT
//
//  Created by Kate Volkova on 22.03.24.
//

import UIKit

final class Task5ViewController: UIViewController {
    // превращаем Post в потокобезопасный класс
    final class Post: Sendable {}

    enum State1: Sendable {
        case loading
        /*
         String уже является Sendable, поэтоу ошибки нет
         */
        case data(String)
    }

    enum State2: Sendable {
        case loading
        /*
         Post не Sendable, поэтому возникает ошибка
         */
        case data(Post) // Out: Associated value 'data' of 'Sendable'-conforming enum 'State2' has non-sendable type 'ViewController.Post'
    }
}
