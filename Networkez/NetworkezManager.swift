//
//  NetworkezManager.swift
//  Networkez
//
//  Created by Yiğit Güleç on 14.01.2023.
//

import Foundation

class NetworkezManager {
    
    private var filePath: String?
    
    static let shared = NetworkezManager()
        
    init() {
        
    }
    
    func saveFileContent(with filePath: String) {
        self.filePath = filePath
        
        let fileUrl = URL(fileURLWithPath: filePath)
        
        do {
            let jsonData = try Data(contentsOf: fileUrl)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            if let jsonDict = jsonObject as? [String: Any] {
                print(jsonDict)
            }
            print(jsonData)
        } catch {
            print("Error")
        }
        
        
        
    }
    
}
