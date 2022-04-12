//
//  String.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 12.04.2022.
//

import Foundation

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

    var htmlToAttributedString: NSAttributedString? {
        var str = "<span style=\"font-size: 18;\">" + self + "</span>"
        str = str.replacingOccurrences(of: "a>", with: "i>")
            .replacingOccurrences(of: "n>", with: "p>")
            .replacingOccurrences(of: "h>", with: "h3>")
            .replacingOccurrences(of: "m>", with: "b>")
            .replacingOccurrences(of: "c>", with: "b>")
            .replacingOccurrences(of: "</p>", with: "")

        guard let data = str.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
