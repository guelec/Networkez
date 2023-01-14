//
//  DropView.swift
//  Networkez
//
//  Created by Yiğit Güleç on 14.01.2023.
//

import Cocoa

protocol DropViewDelegate {
    func dropViewDidUploadFile()
}

class DropView: NSView {

    var filePath: String?
    let expectedExt = ["json"]  //file extensions allowed for Drag&Drop (example: "jpg","png","docx", etc..)
    
    var delegate: DropViewDelegate?

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.layer?.cornerRadius = 32

        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.2).cgColor
            delegate?.dropViewDidUploadFile()
            print("File Path: \(self.filePath ?? "-")")
            // MARK: Read file content
            if let fp = self.filePath {
                NetworkezManager.shared.saveFileContent(with: fp)
            }
            return .copy
        } else {
            return NSDragOperation()
        }
    }

    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
              let path = board[0] as? String
        else { return false }

        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.clear.cgColor
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        self.layer?.backgroundColor = NSColor.clear.cgColor
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
              let path = pasteboard[0] as? String
        else { return false }

        //GET YOUR FILE PATH !!!
        self.filePath = path
        Swift.print("FilePath: \(path)")

        return true
    }
}
