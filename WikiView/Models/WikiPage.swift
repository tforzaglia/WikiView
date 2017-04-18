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

    /// String representing the URL to the page's main thumbnail image
    let imageUrl: String

    init(title: String, extract: String, imageUrl: String) {
        self.title = title
        self.extract = extract
        self.imageUrl = imageUrl
    }
}
