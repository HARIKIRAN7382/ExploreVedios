//
//  GetVediosDetailsData.swift
//  ExploreVedios
//
//  Created by iOS Developer on 26/04/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getVediosDetailsData = try? newJSONDecoder().decode(GetVediosDetailsData.self, from: jsonData)

import Foundation
import UIKit

// MARK: - GetVediosDetailsDatum
class GetVediosDetailsDatum: Codable {
    let title: String?
    let nodes: [Node]?

    init(title: String?, nodes: [Node]?) {
        self.title = title
        self.nodes = nodes
    }
}

// MARK: - Node
class Node: Codable {
    let video: Video?

    init(video: Video?) {
        self.video = video
    }
}

// MARK: - Video
class Video: Codable {
    let encodeURL: String?
    var thumbnail:UIImage?

    enum CodingKeys: String, CodingKey {
        case encodeURL = "encodeUrl"
    }

    init(encodeURL: String?) {
        self.encodeURL = encodeURL
    }
}

typealias GetVediosDetailsData = [GetVediosDetailsDatum]
