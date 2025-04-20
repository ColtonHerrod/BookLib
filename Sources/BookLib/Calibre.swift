//
//  File.swift
//  BookLib
//
//  Created by Colton Herrod on 4/19/25.
//

import Foundation

public class Calibre: Service {
    let fileManager = FileManager.default
    
    enum CodingKeys: String, CodingKey {
        case defaultPath
        case currentBooks
    }
    
    required init(from decoder: Decoder) throws {
        print("Decoding Calibre")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let defaultPath = try container.decode(String.self, forKey: .defaultPath)
        super.init(defaultPath: defaultPath, serviceName: "Calibre")
    }
    
    public init(calibreUrl: URL) throws {
        do {
            let libraryURL = try fileManager.url(
                for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false
            )
            var calibreURL: URL
            // Inelegant way to check if tests are running
            if ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "1" {
                // Code only executes when tests are running
                calibreURL = URL(fileURLWithPath: "./Tests/BookLibTests/Calibre")
            } else if calibreUrl.absoluteString != "" {
                // Use the provided calibre URL
                calibreURL = calibreUrl
            } else {
                calibreURL = libraryURL.appendingPathComponent(Constants.calibreBasePath)
            }
            super.init(defaultPath: calibreURL.path, serviceName: "Calibre")
        } catch {
            print("Error obtaining library URL: \(error)")
            super.init(defaultPath: "", serviceName: "Calibre")
        }
    }
}
