//
//  Document.swift
//  Nerd Ranch Project 1
//
//  Created by Oliver Wilkey on 3/15/19.
//  Copyright © 2019 Oliver Wilkey. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    enum Error: Swift.Error, LocalizedError {
        case UTFSEncoding
        case UTFSDecoding
        
        var failureReaseon: String? {
            switch self {
            case .UTFSEncoding: return "File cannot be encoded in UTF-8."
            case .UTFSDecoding: return "File is not valid UTF-8"
            }
        }
    }

    var contents: String = ""
    
    override class var autosavesInPlace: Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        
        let viewController = windowController.contentViewController as! ViewController
        viewController.contents = contents
        
        self.addWindowController(windowController)
        
        
    }

    override func data(ofType typeName: String) throws -> Data {
        let windowController = windowControllers[0]
        let viewController = windowController.contentViewController as! ViewController
        let contents = viewController.contents ?? ""
        
        guard let data = contents.data(using: .utf8) else {
            throw Document.Error.UTFSEncoding
        }
        return data
    }

    override func read(from data: Data, ofType typeName: String) throws {
        
        guard let contents = String(data: data, encoding: .utf8) else {
            throw Document.Error.UTFSDecoding
        }
    self.contents = contents
    }


}

