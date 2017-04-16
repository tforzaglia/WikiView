//
//  WikiPage.swift
//  WikiView
//
//  Created by Thomas Forzaglia on 4/15/17.
//  Copyright © 2017 Thomas Forzaglia. All rights reserved.
//

internal class WikiPage {
    /// The title of the Wikipedia page
    let title: String

    /// The text of the Wikipedia page's introduction paragraph
    let extract: String

    init(title: String, extract: String) {
        self.title = title
        self.extract = extract
    }
}
