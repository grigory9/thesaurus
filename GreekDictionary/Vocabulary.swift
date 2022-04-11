//
//  Vocabulary.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 30.03.2022.
//

import Foundation

struct Word: Hashable {
    let hash: Int
    let value: String
    let entry: String
}

class Letter {

    enum Letters: String, CaseIterable {
        case alpha
        case beta
        case gamma
        case delta
        case epsilon
        case zeta
        case eta
        case theta
        case iota
        case kappa
        case lambda
        case mu
        case nu
        case xi
        case omicron
        case pi
        case rho
        case sigma
        case tau
        case ypsilon
        case phi
        case chi
        case psi
        case omega
    }

    let value: Letters
    let startHash: Int
    let endHash: Int
    var words: [Word] = []

    init(value: Letters, startHash: Int, endHash: Int) {
        self.value = value
        self.startHash = startHash
        self.endHash = endHash
    }
}

final class Vocabulary {

    private(set) var totalWordsCount = 0

    let letters = [
        Letter(value: .alpha, startHash: 95367431640625, endHash: 190734863281249),
        Letter(value: .beta, startHash: 190734863281250, endHash: 286102294921874),
        Letter(value: .gamma, startHash: 286102294921875, endHash: 381469726562499),
        Letter(value: .delta, startHash: 381469726562500, endHash: 476837158203124),
        Letter(value: .epsilon, startHash: 476837158203125, endHash: 572204589843749),
        Letter(value: .zeta, startHash: 572204589843750, endHash: 667572021484374),
        Letter(value: .eta, startHash: 667572021484375, endHash: 762939453124999),
        Letter(value: .theta, startHash: 762939453125000, endHash: 858306884765624),
        Letter(value: .iota, startHash: 858306884765625, endHash: 953674316406249),
        Letter(value: .kappa, startHash: 953674316406250, endHash: 1049041748046874),
        Letter(value: .lambda, startHash: 1049041748046875, endHash: 1144409179687499),
        Letter(value: .mu, startHash: 1144409179687500, endHash: 1239776611328124),
        Letter(value: .nu, startHash: 1239776611328125, endHash: 1335144042968749),
        Letter(value: .xi, startHash: 1335144042968750, endHash: 1430511474609374),
        Letter(value: .omicron, startHash: 1430511474609375, endHash: 1525878906249999),
        Letter(value: .pi, startHash: 1525878906250000, endHash: 1621246337890624),
        Letter(value: .rho, startHash: 1621246337890625, endHash: 1716613769531249),
        Letter(value: .sigma, startHash: 1716613769531250, endHash: 1811981201171874),
        Letter(value: .tau, startHash: 1811981201171875, endHash: 1907348632812499),
        Letter(value: .ypsilon, startHash: 1907348632812500, endHash: 2002716064453124),
        Letter(value: .phi, startHash: 2002716064453125, endHash: 2098083496093749),
        Letter(value: .chi, startHash: 2098083496093750, endHash: 2193450927734374),
        Letter(value: .psi, startHash: 2193450927734375, endHash: 2288818359374999),
        Letter(value: .omega, startHash: 2288818359375000, endHash: 2384185791015624),
    ]

    init() {

    }

    func populate(letter: Letter.Letters, hash: Int, value: String, entry: String) {
        self.totalWordsCount += 1
        self.letters
            .first { $0.value == letter }?
            .words
            .append(Word(hash: hash, value: value, entry: entry))
    }

    func find(by number: Int) -> Word? {
        var currentNumber = 0
        var index = number

        for (letterIndex, letter) in letters.enumerated() {
            if letterIndex != 0 {
                index -= letters[letterIndex - 1].words.count
            }

            if index < letter.words.count {
                let startIndex = letter.words.startIndex

                let wordIndex = letter.words.index(startIndex, offsetBy: index)
                return letter.words[wordIndex]
            }
        }
        return nil
    }

    func findIndex(by hash: Int) -> Int? {
        var currentNumber = 0
        var letter: Letter?

        for curLetter in letters {
            currentNumber = curLetter.words.count + currentNumber
            if curLetter.startHash <= hash && curLetter.endHash >= hash {
                letter = curLetter
                break
            }
        }

        guard let letter = letter else {
            return nil
        }

        var prevWord: Word = letter.words.first!
        for (wordIndex, word) in letter.words.enumerated() {
            if prevWord.hash <= hash && word.hash > hash {
                return currentNumber - letter.words.count + wordIndex
            }
            prevWord = word
        }

        return nil
    }

}


extension String {
    func greekHash() -> Int {
        var sum: Int = 0;

        for (i, letter) in self.enumerated() {
            let valueDec = pow(25, 10 - i)
            let value = NSDecimalNumber(decimal: valueDec).intValue

            var mult = 1
            switch letter {
            case "α": mult = 1
            case "β": mult = 2
            case "γ": mult = 3
            case "δ": mult = 4
            case "ε": mult = 5
            case "ζ": mult = 6
            case "η": mult = 7
            case "θ": mult = 8
            case "ι": mult = 9
            case "κ": mult = 10
            case "λ": mult = 11
            case "μ": mult = 12
            case "ν": mult = 13
            case "ξ": mult = 14
            case "ο": mult = 15
            case "π": mult = 16
            case "ρ": mult = 17
            case "ς": mult = 18
            case "σ": mult = 18
            case "τ": mult = 19
            case "υ": mult = 20
            case "φ": mult = 21
            case "χ": mult = 22
            case "ψ": mult = 23
            case "ω": mult = 24
            default: break
            }
            sum += mult * value
        }

        return sum
    }
}
