//
//  TestTests.swift
//  cliTests
//
//  Created by Colton Herrod on 2/16/25.
//

import Testing
import BookLib


@Test func testAppleBooks() {
    // Test the AppleBooks class
    
    
    let appleBooks = try? AppleBooks()
    let book = Book(title: "Metamorphoses", author: "Ovid", path: "Test", serviceName: "Apple Books")
    
    #expect(appleBooks != nil)
    
    let bookList = appleBooks?.getBooks()
    
    #expect(bookList != nil)
    #expect(bookList?.count == 1)
    #expect(bookList?.first?.title == book.title)
    #expect(bookList?.first?.author == book.author)
    #expect(bookList?.first?.serviceName == book.serviceName)
}
