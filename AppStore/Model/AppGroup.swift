//
//  AppGroup.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {

  let feed: Feed

}

struct Feed: Decodable {
  let title: String
  let results: [FeedResult]
}

struct FeedResult: Decodable {
  let name: String
  let artistName: String
  let artworkUrl100: String
}
