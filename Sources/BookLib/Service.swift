import Foundation
import EPUBKit

public class Service: Decodable {
    enum CodingKeys: String, CodingKey {
        case defaultPath
        case serviceName
        case currentBooks
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        defaultPath = try container.decode(String.self, forKey: .defaultPath)
        serviceName = try container.decode(String.self, forKey: .serviceName)
        currentBooks = try container.decode([Book].self, forKey: .currentBooks)
    }

    // Add properties and methods for the Service class here
    public let defaultPath: String
    public var serviceName: String
    public var currentBooks: [Book] = []

    init(defaultPath: String, serviceName: String) {
        self.defaultPath = defaultPath
        self.serviceName = serviceName
        self.currentBooks = getCurrentBooks(path: defaultPath)
    }

    public func getCurrentBooks(path: String) -> [Book] {
        let fileManager = FileManager.default
        var books: [Book] = []
        do {
            let bookPaths = try fileManager.contentsOfDirectory(atPath: path)
            for book: String in bookPaths {
                let bookUrl = URL(fileURLWithPath: "\(path)/\(book)")
                if bookUrl.pathExtension != "epub" {
                    continue
                }
                guard let book = EPUBDocument(url: bookUrl) else {
                    print("Failed to open book at \(bookUrl.path)")
                    continue
                }
                let bookTitle = (book.title)!
                let bookAuthor = (book.author)!
                let newBook: Book = Book(
                    title: bookTitle, author: bookAuthor, path: path, serviceName: serviceName
                )
                books.append(newBook)
            }
            return books
        } catch {
            print("Failed to list books: \(error)")
            return []
        }
    }

    public func getBooks() -> [Book] {
        return currentBooks
    }

    public func copyBook(bookTitle: String, destination: String) {
        let book = currentBooks.first { $0.title == bookTitle }
        if book == nil {
            print("Book not found.")
            return
        }
        book!.copy(destinationPath: destination)
    }
}
