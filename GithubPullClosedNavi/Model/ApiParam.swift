//
//  ApiParam.swift
//  GithubPullClosedNavi
//
//  Created by Naman Singh on 11/04/22.
//

import Foundation
import UIKit

struct GitResponse: Codable {
    let id: Int
    let node_id: String
    let number: Int
    let state: String
    let created_at: String
    let closed_at: String?
    let user: User?
}

struct User: Codable{
    let avatar_url: String?
}


