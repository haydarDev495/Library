//
//  BooksViewController.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import UIKit
import SVProgressHUD

class BooksViewController: UIViewController {

    // - UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    // - Data
    private var bookArray: [doc] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    

}

// MARK: -
// MARK: Configure
private extension BooksViewController {
    func configure() {
        configureCollectionView()
        importJson()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func importJson () {
        guard let jsonUrl = URL(string: "https://openlibrary.org/search.json?author=A") else { return }
        URLSession.shared.dataTask(with: jsonUrl, completionHandler: { [weak self] (data, response, error) in
            guard let data = data , let sSelf = self else { return }
            do{
                let object = try JSONDecoder().decode(BookViewModel.self, from: data)
                sSelf.bookArray = object.docs
                DispatchQueue.main.async { [weak self] in
                    guard let sSelf = self else { return }
                    sSelf.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func showDetailVC() {
        let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -
// MARK: CollectionViewDataSource
extension BooksViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionViewCell", for: indexPath) as! BooksCollectionViewCell
        cell.setupUI(book: bookArray[indexPath.item])
        return cell
    }
    
    
}

// MARK: -
// MARK: CollectionViewDelegate
extension BooksViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailVC()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//    }
}

