//
//  MovieDetailViewController.swift
//  AdvancedTestingDemo
//
//  Created by RishiChaurasia on 18/04/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var subHeadingLabel: UILabel!
    @IBOutlet private weak var censoredNameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var collectionPriceLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    var movieDetail: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setMovieDetails()
    }
    
    // MARK: UI UPDATION
    
    private func setMovieDetails() {
        resetAllFields()
        movieImageView.loadImageAsync(stringURL: movieDetail?.thumbnailURL)
        if let trackName = movieDetail?.trackName {
            let attributedTrackName = UtilityMethod.getTitleAndTextAttributedString(titleString: Constants.MovieDetailViewTitles.trackName, textString: trackName, fontSize: 24)
            headerLabel.attributedText = attributedTrackName
        }
        if let artistName = movieDetail?.artistName {
            let attributedArtistName = UtilityMethod.getTitleAndTextAttributedString(titleString: Constants.MovieDetailViewTitles.artistName, textString: artistName)
            subHeadingLabel.attributedText = attributedArtistName
        }
        if let censoredNwme = movieDetail?.censoredName {
            let attributedCensoredName = UtilityMethod.getTitleAndTextAttributedString(titleString: Constants.MovieDetailViewTitles.censoredName, textString: censoredNwme)
            censoredNameLabel.attributedText = attributedCensoredName
        }
        if let country = movieDetail?.country {
            let attributedCountry = UtilityMethod.getTitleAndTextAttributedString(titleString: Constants.MovieDetailViewTitles.country, textString: country)
            countryLabel.attributedText = attributedCountry
        }
        if let trackPrice = movieDetail?.trackPrice {
            let attributedTrackPrice = UtilityMethod.getTitleAndTextAttributedString(titleString: Constants.MovieDetailViewTitles.trackPrice, textString: trackPrice)
            trackPriceLabel.attributedText = attributedTrackPrice
        }
        if let collectionPrice = movieDetail?.collectionPrice {
            let attributedCollectionPrice = UtilityMethod.getTitleAndTextAttributedString(titleString: Constants.MovieDetailViewTitles.collectionPrice, textString: collectionPrice)
            collectionPriceLabel.attributedText = attributedCollectionPrice
        }
    }
    
    private func resetAllFields() {
        headerLabel.text =  ""
        subHeadingLabel.text = ""
        movieImageView.image = nil
        censoredNameLabel.text =  ""
        countryLabel.text = ""
        trackPriceLabel.text = ""
        collectionPriceLabel.text = ""
    }
}


extension UIImageView {
    func loadImageAsync(stringURL: String?) {
        guard let urlString = stringURL, let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
