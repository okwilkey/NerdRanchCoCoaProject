//
//  ViewController.swift
//  Nerd Ranch Project 1
//
//  Created by Oliver Wilkey on 3/15/19.
//  Copyright © 2019 Oliver Wilkey. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let speechSynthesizer = NSSpeechSynthesizer()
    
    @IBOutlet var textView: NSTextView!

    var contents: String {
        get {
            return textView.string
        }
        set {
            textView.string = newValue
        }
    }
    
    @IBAction func speakButtonClicked(_ sender: NSButton) {
        if let contents = textView?.string, !contents.isEmpty {
            speechSynthesizer.startSpeaking(contents)
        } else {
            speechSynthesizer.startSpeaking("The document is empty")
        }
}

    @IBAction func stopButtonClicked(_ sender: NSButton) {
       speechSynthesizer.stopSpeaking()
}

}

