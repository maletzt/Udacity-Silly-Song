//
//  ViewController.swift
//  Udacity Silly Song
//
//  Created by Troy Maletz on 8/13/16.
//  Copyright © 2016 Troy Maletz. All rights reserved.
//

import UIKit

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        self.nameField.autocapitalizationType = .Words
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
        nameField.text?.capitalizedString
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if nameField.text != "" {
            lyricsView.text = lyricsForName(bananaFanaTemplate, fullName: nameField.text!)
        }
    }

}

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercaseString.stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: nil)
    let vowelSet = NSCharacterSet(charactersInString: "aeiou")
    
    if let firstVowelRange = name.rangeOfCharacterFromSet(vowelSet, options: .CaseInsensitiveSearch) {
        return lowercaseName.substringFromIndex(firstVowelRange.startIndex)
    }
    
    // no vowels = return the full name
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(fullName)
    
    let lyrics = lyricsTemplate
        .stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
        .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
    
    return lyrics

}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joinWithSeparator("\n")



