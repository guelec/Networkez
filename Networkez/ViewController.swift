//
//  ViewController.swift
//  Networkez
//
//  Created by Yiğit Güleç on 14.01.2023.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var dropView: DropView?
    @IBOutlet weak var dropImageView: NSImageView?
    @IBOutlet weak var resetButton: NSButton?
    @IBOutlet weak var convertButton: NSButton?
    @IBOutlet weak var languageComboButton: NSComboButton?
    @IBOutlet weak var typeComboButton: NSComboButton?
    @IBOutlet weak var codableCheckbox: NSButton?
    @IBOutlet weak var varCheckbox: NSButton?
    @IBOutlet weak var optionalCheckbox: NSButton?
    @IBOutlet weak var initializerCheckbox: NSButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initComboBox()
        arrangeUI()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func initUI() {
        dropView?.delegate = self
    }
    
    func arrangeUI() {
        
    }
    
    func initComboBox() {
        let menu = NSMenu()
        let swiftItem = NSMenuItem(title: "Swift", action: #selector(languageSelected), keyEquivalent: "")
        let objcItem = NSMenuItem(title: "Obj-C", action: #selector(languageSelected), keyEquivalent: "")
        menu.addItem(swiftItem)
        menu.addItem(objcItem)
        languageComboButton?.menu = menu
        languageComboButton?.title = "-"
        
        let menuTwo = NSMenu()
        let classItem = NSMenuItem(title: "Class", action: #selector(typeSelected), keyEquivalent: "")
        let structItem = NSMenuItem(title: "Struct", action: #selector(typeSelected), keyEquivalent: "")
        menuTwo.addItem(classItem)
        menuTwo.addItem(structItem)
        typeComboButton?.menu = menuTwo
        typeComboButton?.title = "-"
    }
}

extension ViewController {
    
    @IBAction func resetButtonTapped(_ sender: NSButton) {
        print("resetButtonTapped : \(sender.isEnabled)")
        self.dropImageView?.image = NSImage(named: "defaultDragView")
    }
    
    @IBAction func convertButtonTapped(_ sender: NSButton) {
        print("convertButtonTapped : \(sender.isEnabled)")
    }
    
    @IBAction func codableCheckboxTapped(_ sender: NSButton) {
        print("codableCheckboxTapped : \(sender.intValue)")
    }
    
    @IBAction func varCheckboxTapped(_ sender: NSButton) {
        print("varCheckboxTapped : \(sender.intValue)")
    }
    
    @IBAction func optionalCheckboxTapped(_ sender: NSButton) {
        print("optionalCheckboxTapped : \(sender.intValue)")
    }
    
    @IBAction func initializerCheckboxTapped(_ sender: NSButton) {
        print("initializerCheckboxTapped : \(sender.intValue)")
    }
    
    @objc func languageSelected(_ sender: NSMenuItem) {
        print(sender.title)
        languageComboButton?.title = sender.title
    }
    
    @objc func typeSelected(_ sender: NSMenuItem) {
        print(sender.title)
        typeComboButton?.title = sender.title
        typeComboButton?.isEnabled = true
        typeComboButton?.isHighlighted = true
    }
}

extension ViewController: DropViewDelegate {
    func dropViewDidUploadFile() {
        self.dropImageView?.image = NSImage(named: "uploadedDragView")
    }
}
