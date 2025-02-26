//
//  ResponseType.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/26/25.
//

import Foundation

struct ResponseType<T: Decodable>: Decodable {
    let code: Int
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}
