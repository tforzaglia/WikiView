//
//  WikiPageViewController.swift
//  WikiView
//
//  Created by Thomas Forzaglia on 4/16/17.
//  Copyright © 2017 Thomas Forzaglia. All rights reserved.
//

import UIKit

public class WikiPageViewController: UIViewController {
    /// The search term to use with the Wikipedia API
    private var searchTerm: String

    /// An instance of the client class that interacts with the API
    private let wikiClient = WikipediaClient()

    /// The title of the Wiki page
    private let titleLabel = UILabel(frame: .zero)

    /// The introductory paragraph of the wiki page
    private let introParagraphTextView = UITextView(frame: .zero)

    /// The main thumbnail from the wiki page
    private let thumbnailImageView = UrlImageView()

    /// View separator between the title and image
    private let viewSeparator = UIView(frame: .zero)

    /// Button allowing a user to dismiss the view
    private let closeButton = UIButton(frame: .zero)

    /// The page built from the response of the API call
    private var wikiPage: WikiPage? = nil {
        didSet {
            setupTitleLabel()
            setupViewSeparator()
            setupThumbnailImageView()
            setupIntroParagraphTextView()
            setupCloseButton()

            applyConstraints()
        }
    }

    private var isPhone: Bool {
        return traitCollection.horizontalSizeClass == .compact
    }

    public init(withSearchTerm searchTerm: String) {
        self.searchTerm = searchTerm

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        searchForWikiPage()
    }

    /// Hit the Wikipedia API to get the required information
    private func searchForWikiPage() {
        wikiClient.searchForWikiPage(
            withTitle: searchTerm,
            onSuccess: { [weak self] wikiPage in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.wikiPage = wikiPage
                }
            }, onError: { error in
                print(error)
            }
        )
    }

    // MARK: - UI Setup

    /// Setup the label containing the article's title
    private func setupTitleLabel() {
        let fontSize: CGFloat = isPhone ? 24 : 30
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: fontSize)
        titleLabel.text = wikiPage?.title

        view.addSubview(titleLabel)
    }

    /// Setup the view separator
    private func setupViewSeparator() {
        viewSeparator.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator.backgroundColor = .gray

        view.addSubview(viewSeparator)
    }

    /// Setup the image view containing the article's main thumbnail
    private func setupThumbnailImageView() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.setURLImage(url: wikiPage?.imageUrl)

        view.addSubview(thumbnailImageView)
    }

    /// Setup the text view containing the article's intro paragraph
    private func setupIntroParagraphTextView() {
        let fontSize: CGFloat = isPhone ? 14 : 16
        introParagraphTextView.translatesAutoresizingMaskIntoConstraints = false
        introParagraphTextView.isEditable = false
        introParagraphTextView.textAlignment = .left
        introParagraphTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: fontSize)
        introParagraphTextView.text = wikiPage?.extract

        view.addSubview(introParagraphTextView)
    }

    /// Setup the dismiss view button
    private func setupCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .white
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 24)
        closeButton.addTarget(self, action: #selector(handleCloseButtonTapped(sender:)), for: .touchUpInside)

        view.addSubview(closeButton)
    }

    /// Activate constraints on all the controls that make up the UI
    private func applyConstraints() {
        let width: CGFloat = isPhone ? view.bounds.width - 30 : 400
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        viewSeparator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        viewSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        viewSeparator.widthAnchor.constraint(equalToConstant: width).isActive = true
        viewSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        thumbnailImageView.topAnchor.constraint(equalTo: viewSeparator.bottomAnchor, constant: 10).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        thumbnailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        introParagraphTextView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 15).isActive = true
        introParagraphTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        introParagraphTextView.widthAnchor.constraint(equalToConstant: width).isActive = true
        introParagraphTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    // MARK: - Button Action Handler

    @objc private func handleCloseButtonTapped(sender: UIButton) {
        dismiss(animated: true)
    }
}
