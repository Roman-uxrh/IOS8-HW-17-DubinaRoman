//
//  Exe.swift
//  Pr2503
//
//  Created by admin on 15.02.2023.
//

import Foundation

extension String {
    private static let digits = "0123456789"
    private static let lowercase = "abcdefghijklmnopqrstuvwxyz"
    private static let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private static let punctuation = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    private static let letters = lowercase + uppercase
    static let printable = digits + letters + punctuation

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    index < array.count ? Character(array[index]) : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    } else {
        str.replace(at: str.count - 1, with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }

    return str
}
