//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let arrayOfNumbers = [1, 2, 3, 4]
let arrayOfString = arrayOfNumbers.map { "\($0)" }

fileprivate let itemDataSouce: [[(name: String, image: String)]] = [
    [
        ("回忆篇", "1"),
        ("现在篇", "2"),
        ("N的调查报告", "3"),
        ],
    [
        ("每个人的故事", "4"),
        ],
]

let indexPath: IndexPath = [0,2]
indexPath[1]

itemDataSouce[indexPath[0]][indexPath[1]].name

