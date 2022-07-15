//
//  VK.swift
//  vk-test
//
//  Created by Иван Сурганов on 13.07.2022.
//

import Foundation

struct Apps: Codable {
    let body: ResponseModel
    let status: Int
}

struct ResponseModel: Codable {
    let services: [Services]
}

struct Services: Codable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}
