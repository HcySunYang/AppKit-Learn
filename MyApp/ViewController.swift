//
//  ViewController.swift
//  MyApp
//
//  Created by ChunyangHuo on 2025/12/26.
//

import Cocoa

class ViewController: NSViewController {
    
    override func loadView() {
        // Create the view programmatically
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 480, height: 270))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

