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
    
    @IBOutlet private var searchField: SearchTextField!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.addTarget(self, action: #selector(searchValueDidChange), for: .editingChanged)
    }

    @objc
    func searchValueDidChange() {
        guard let textHash = searchField.text?.greekHash() else { return }
        let index = AppDelegate.vocabulary.findIndex(by: textHash) ?? 0
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = AppDelegate.vocabulary.find(by: indexPath.row)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wordVC = storyboard.instantiateViewController(withIdentifier: "WordViewControllerID") as! WordViewController
        wordVC.word = word

        self.present(wordVC, animated: true, completion: nil)
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppDelegate.vocabulary.totalWordsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "WordRow", for: indexPath) as! WordTableCell
        let word = AppDelegate.vocabulary.find(by: indexPath.row)
        row.title.text = word?.value
        row.value = word?.entry
        return row
    }
}
