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
    @IBOutlet weak var autorName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var raitinView: UILabel!
    
    // - Data
    var detailBook: Doc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: Configure
private extension DetailViewController {
    func configure() {
        setupUI()
    }
    
    func setupUI() {
        guard let name = detailBook?.author_name?.first ,
              let image = detailBook?.cover_i,
              let detailInfo = detailBook?.subtitle,
              let raiting = detailBook?.publisher?.first else { return }
        
        autorName.text = name
//        imageView.kf.setImage(with: <#T##Source?#>)
    }
}
