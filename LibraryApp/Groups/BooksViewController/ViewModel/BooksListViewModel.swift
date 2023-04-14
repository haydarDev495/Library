//
//  BooksListViewModel.swift
//  LibraryApp
//
//  Created by Haydar Bekmuradov on 14.04.23.
//

import Foundation

struct BooksListViewModel: Decodable {
    let book: [BookViewModel]
}

struct BookViewModel: Decodable{
    let start: Int?
    let num_found: Int?
    let docs: [Doc]
    
}

struct Doc: Decodable{
    let title_suggest: String?
    let subtitle: String?
    let author_name: [String]?
    let first_publish_year: Int?
    let cover_i: Int?
    let publisher: [String]?
    let author_alternative_name: [String]?
    let ia: [String]?
    let ratings_average: Double?
}
