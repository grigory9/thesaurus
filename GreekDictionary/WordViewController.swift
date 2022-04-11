//
//  WordViewController.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 11.04.2022.
//

import UIKit

final class WordViewController: UIViewController {
    @IBOutlet weak var descriptionText: UITextView!

    var word: Word?

    override func viewDidLoad() {
        self.descriptionText.attributedText = word?.entry.htmlToAttributedString
    }
}

extension String {
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
