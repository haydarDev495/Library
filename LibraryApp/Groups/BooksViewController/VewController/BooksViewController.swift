//
//  BooksViewController.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import UIKit

class BooksViewController: UIViewController {

    // - UI
    @IBOutlet weak var loadingLabel: LoadingLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // - Data
    private var bookArray: [Doc] = []
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkOnbording()
    }

}

// MARK: -
// MARK: Configure
private extension BooksViewController {
    func configure() {
        setupUI()
        configureCollectionView()
        fetchBooks()
    }
    
    func setupUI() {
        loadingLabel.start()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func checkOnbording() {
        if !UserDefaultsManager.shared.getValue(data: .onboarding) {
            let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnbordingViewController") as! OnbordingViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func fetchBooks () {
        currentPage += 1
        guard let jsonUrl = URL(string: "\(AppConstant.domain)/search.json?q=*&fields=*,&page=\(currentPage)&limit=5") else { return }
        URLSession.shared.dataTask(with: jsonUrl, completionHandler: { [weak self] (data, response, error) in
            guard let data = data , let sSelf = self else { return }
            do{
                let object = try JSONDecoder().decode(BookViewModel.self, from: data)
                sSelf.bookArray += object.docs
                DispatchQueue.main.async { [weak self] in
                    guard let sSelf = self else { return }
                    sSelf.updateCollectionView()
                }
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
        loadingLabel.stop(withText: "")
    }
    
    func showDetailVC(indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.detailBook = bookArray[indexPath.item]
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
        showDetailVC(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == bookArray.count - 1 {
            fetchBooks()
        }
    }
}

