//
//  WikipediaClient.swift
//  WikiView
//
//  Created by Thomas Forzaglia on 4/15/17.
//  Copyright © 2017 Thomas Forzaglia. All rights reserved.
//

import Alamofire
import SwiftyJSON

internal class WikipediaClient {
    /// Query the Wikipedia API to return page's introduction paragraph
    ///
    /// - parameter title:     the wikipedia search term
    /// - parameter onSuccess: block to executed on successful API call
    /// - parameter onError:   block to executed on unsuccessful API call
    internal func searchForWikiPage(withTitle title: String, onSuccess: @escaping (WikiPage) -> Void, onError: @escaping (Error) -> Void) {
        let urlEncodedTitle = title.replacingOccurrences(of: " ", with: "%20")
        let url = "https://en.wikipedia.org/w/api.php?action=query&prop=extracts%7Cpageimages&exintro&explaintext&pithumbsize=200&titles=\(urlEncodedTitle)&format=json"
        Alamofire.request(url, encoding: JSONEncoding.default, headers: httpHeaders()).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let wikiPage = self?.wikiPageFromJson(json: json) {
                    onSuccess(wikiPage)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }

    /// Parse the JSON returned from the Wikipedia API
    ///
    /// - parameter json: json returned from the Wikipedia API
    /// - returns: `WikiPage` object containing the title and intro paragraph text
    private func wikiPageFromJson(json: JSON) -> WikiPage? {
        let pageIdDictionary = json["query"]["pages"].first?.1
        guard let title = pageIdDictionary?["title"].string else { return nil }
        guard let extract = pageIdDictionary?["extract"].string else { return nil }
        guard let imageUrl = pageIdDictionary?["thumbnail"].dictionary?["source"]?.string else { return nil }

        return WikiPage(title: title, extract: extract, imageUrl: imageUrl)
    }

    /// Create dictionary of headers to be used in API calls
    ///
    /// - returns: `Dictionary` of `HTTPHeaders`
    private func httpHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        return headers
    }
}