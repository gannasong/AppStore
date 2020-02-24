//
//  SearchResult.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/15.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
  let resultCount: Int
  let results: [Result]
}

struct Result: Decodable {
  let trackName: String
  let primaryGenreName: String
  let averageUserRating: Float?
  let screenshotUrls: [String]
  let artworkUrl100: String
  let formattedPrice: String
  let description: String
  let releaseNotes: String
}
