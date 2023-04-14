//
//  DetailViewController.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    // - UI
    @IBOutlet weak var firtPublish: UILabel!
    @IBOutlet weak var autorName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var raitinLabel: UILabel!
    
    // - Data
    var detailBook: Doc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: -
// MARK: Configure
private extension DetailViewController {
    func configure() {
        setupUI()
    }
    
    func setupUI() {
        
        detailInfo.text = "Detail: \(detailBook?.subtitle ?? "Dont have information")"
        autorName.text = "Autor: \(detailBook?.author_name?.first ?? "Dont have Name")"

        if let year = detailBook?.first_publish_year {
            firtPublish.text = "Publish year: \(String(year))"
        }
        
        if let raiting = detailBook?.ratings_average {
            raitinLabel.text = "Raiting: \(String(raiting))"
        }
        
        guard  let cover = detailBook?.cover_i else { return }
        setupBookImage(coverI: cover)
    }
    
    func setupBookImage(coverI : Int?) {
        guard let cover = coverI else { return }
        guard let url = URL(string: "\(AppConstantImage.domain)\(AppConstantImage.id)" + "\(cover)" + "-M.jpg") else { return }
        imageView.kf.setImage(with: url)
    }
}
