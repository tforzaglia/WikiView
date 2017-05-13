//
//  WikiPageController.swift
//  WikiView
//
//  Created by Thomas Forzaglia on 5/12/17.
//  Copyright © 2017 Thomas Forzaglia. All rights reserved.
//

public class WikiPageController {
    /// An instance of the client class that interacts with the API
    private let wikiClient = WikipediaClient()

    public func getWikiPage(withSearchTerm searchTerm: String, onSuccess: @escaping (WikiPage) -> Void, onError: @escaping (Error) -> Void) {
        self.wikiClient.searchForWikiPage(
            withTitle: searchTerm,
            onSuccess: { wikiPage in
                onSuccess(wikiPage)
            },
            onError: { error in
                onError(error)
            }
        )
    }
}
