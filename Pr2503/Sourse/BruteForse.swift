//
//  File.swift
//  Pr2503
//
//  Created by admin on 15.02.2023.
//

import Foundation

final class BruteForce {
    
    weak var delegate: BruteForcerProtocol?
    private let queue = DispatchQueue(label: "queue", qos: .userInteractive)
    var isStarted = false
    
    func bruteForce(passwordToUnlock: String) {
        let allowedCharacters = String.printable.map { String($0) }
        
        isStarted = true
        var password = ""
        
        queue.async {
            while password != passwordToUnlock && self.isStarted {
                password = self.generateBruteForce(password, fromArray: allowedCharacters)
                print(password)
                
                DispatchQueue.main.async {
                    self.delegate?.showPasswordLabel(text: password)
                }
            }
            
            DispatchQueue.main.async {
                let text: String
                if !self.isStarted && password != passwordToUnlock {
                    text = "Пароль не подобран"
                } else {
                    text = "Пароль подобран - \(password)"
                }
                self.delegate?.showPasswordLabel(text: text)
                self.delegate?.stopAnimating()
            }
        }
    }
    
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        index < array.count ? Character(array[index]) : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
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
}
