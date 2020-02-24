//
//  Reviews.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
  let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
  let entry: [Entry]
}

struct Entry: Decodable {
  let author: Author
  let title: Label
  let content: Label
  let rating: Label

  enum CodingKeys: String, CodingKey {
    case author, title, content
    case rating = "im:rating"
  }
}

struct Author: Decodable {
  let name: Label
}

struct Label: Decodable {
  let label: String
}
