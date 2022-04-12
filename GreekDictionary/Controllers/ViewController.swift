//
//  ViewController.swift
//  GreekDictionary
//
//  Created by Grigorii Metelev on 30.03.2022.
//

import UIKit

final class WordTableCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    var value: String?
}

final class ViewController: UIViewController {
    
    @IBOutlet private var searchField: UITextField!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.addTarget(self, action: #selector(searchValueDidChange), for: .editingChanged)
    }

    @objc
    func searchValueDidChange() {
        guard let textHash = searchField.text?.greekHash() else { return }
        let index: IndexPath = Vocabulary.shared.findIndex(by: textHash) ?? IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: index, at: .top, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = Vocabulary.shared.find(section: indexPath.section, row: indexPath.row)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wordVC = storyboard.instantiateViewController(withIdentifier: "WordViewControllerID") as! WordViewController
        wordVC.word = word

        self.present(wordVC, animated: true, completion: nil)
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        Letter.Letters.allCases.map { $0.greekValue }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Letter.Letters.allCases[section].greekValue
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Vocabulary.shared.letters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Vocabulary.shared.letters[section].words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "WordRow", for: indexPath) as! WordTableCell
        let word = Vocabulary.shared.find(section: indexPath.section, row: indexPath.row)
        row.title.text = word?.value
        row.value = word?.entry
        return row
    }
}
