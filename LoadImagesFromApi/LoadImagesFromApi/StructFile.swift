//
//  StructFile.swift
//  LoadImagesFromApi
//
//  Created by Deepashri Khawase on 26.04.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let page, perPage: Int
    let photos: [Photo]
    let nextPage, prevPage: String
    
    
    init(page : Int, perPage: Int,photos : [Photo], nextPage : String, prevPage: String) {
        self.page = page
        self.perPage = perPage
        self.nextPage = nextPage
        self.prevPage = prevPage
        self.photos = photos
    }
    
    
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case nextPage = "next_page"
        case prevPage = "prev_page"
    }


struct Photo: Codable {
    let id, width, height: Int
    let url: String
    let photographer: String
    let photographerURL: String
    let src: Src
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case src
    }
}
}
struct Src: Codable {
    let original, large2X, large, medium: String
    let small, portrait, landscape, tiny: String
    
    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}

