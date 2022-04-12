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
