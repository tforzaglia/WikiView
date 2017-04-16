//
//  WikiViewTests.swift
//  WikiViewTests
//
//  Created by Thomas Forzaglia on 4/15/17.
//  Copyright © 2017 Thomas Forzaglia. All rights reserved.
//

import XCTest
@testable import WikiView

class WikiViewTests: XCTestCase {
    let client = WikipediaClient()
    
    func testGetWikiPageLink() {
        let ex = expectation(description: "Get a wikipedia page title and extract for the given search term")
        client.searchForWikiPage(
            withTitle: "Anna Kendrick",
            onSuccess: { wikiPage in
                print(wikiPage.title)
                print(wikiPage.extract)

                ex.fulfill()
            },
            onError:  { error in
                print(error)

                ex.fulfill()
            }
        )

        waitForExpectations(timeout: 100) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            } else {
                XCTAssert(true)
            }
        }
    }
}
