//
//  Book.swift
//  Apple Books Packager
//
//  Created by Colton Herrod on 9/29/24.
//

import Foundation
import EPUBKit

public class Book: Decodable, Identifiable {
    public var title: String
    public var author: String
    public var path: String
    public var serviceName: String

    public init(title: String, author: String, path: String, serviceName: String) {
        self.title = title
        self.author = author
        self.path = path
        self.serviceName = serviceName
    }

    public func copy(destinationPath: String) {
        print("Copying \(title) to \(destinationPath)...")
        if destinationPath == "" {
            print("Please provide a destination.")
            return
        }

        let fileManager = FileManager.default
        let bookURL = URL(fileURLWithPath: "\(path)/\(title).epub")
        let destinationURL = URL(fileURLWithPath: "\(destinationPath)/\(title).epub")

        do {
            try fileManager.copyItem(at: bookURL, to: destinationURL)
            print("Copied \(title) to \(destinationPath).")
        } catch {
            print("Failed to copy \(title) to \(destinationPath): \(error)")
        }
    }
}
