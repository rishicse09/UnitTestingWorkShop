//
//  MovieResponse.swift
//  AdvancedTestingDemo
//
//  Created by RishiChaurasia on 18/04/22.
//

import Foundation
struct MovieResponse: Decodable {
    var results = [Movies]()
}
