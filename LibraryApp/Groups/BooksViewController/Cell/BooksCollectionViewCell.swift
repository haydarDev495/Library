//
//  BooksCollectionViewCell.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import UIKit
import Kingfisher

class BooksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    func setupUI(book: doc) {
        guard let nameFirst = book.author_name?.first, let year = book.first_publish_year else { return }
        title.text = "Author name: \(nameFirst)"
        data.text = "Firt publish year: \(year)"
        setupBookImage(coverI: book.cover_i)
    }
    
    func setupBookImage(coverI : Int?) {
        guard let cover = coverI else { return }

        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(cover)" + "-M.jpg") else { return }
        bookImage.kf.setImage(with: url)
    }
}
