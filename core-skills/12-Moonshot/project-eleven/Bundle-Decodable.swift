//
//  Bundle-Decodable.swift
//  project-eleven
//
//  Created by Ashkan Ebtekari on 11/6/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ filename: String) -> T {
        guard let url = self.url(forResource: filename, withExtension: nil) else {
            fatalError("Unable to locate \(filename) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("UNable to decode file from bundle")
        }
        
        return loaded
    }
}
