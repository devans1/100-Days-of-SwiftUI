//
//  FileManager-Documents.swift
//  BucketList
//
//  Created by David Evans on 2/5/2022.
//

import Foundation

extension FileManager {

    func writeDocument(name: String, data: String) throws {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        try data.write(to: url, atomically: true, encoding: .utf8)
    }

    func readDocument(name: String) throws -> String {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        let input = try String(contentsOf: url)
        return input
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
