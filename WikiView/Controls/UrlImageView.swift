//
//  UrlImageView.swift
//  WikiView
//
//  Created by Thomas Forzaglia on 4/18/17.
//  Copyright © 2017 Thomas Forzaglia. All rights reserved.
//

import UIKit

class UrlImageView: UIImageView {
    private var dataTask: URLSessionDataTask? = nil
    private var existingURL: URL? = nil

    override var image: UIImage? {
        didSet {
            existingURL = nil
        }
    }

    open override func removeFromSuperview() {
        teardown()
    }

    deinit {
        teardown()
    }

    public func setURLImage(url: String) {
        teardown()
        if let uri = URL(string: url), existingURL != uri {
            let request = NSURLRequest(url: uri)

            // if there's an existing image (from a dequeued cell), remove it
            image = nil

            // stop any repeated requests for the same URL
            existingURL = uri

            dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if let img = data {
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.image = UIImage(data: img)

                        // now that the image is set, ensure we don't try to request the same again
                        strongSelf.existingURL = uri
                    }
                }
            }
            dataTask?.resume()
        }
    }

    private func teardown() {
        if let task = dataTask {
            task.cancel()
        }
    }
}
