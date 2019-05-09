//
//  ServerResponse.swift
//  Quizzlet
//
//  Created by Zeljko halle on 09/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation

enum ServerResponse: Int {
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    case BAD_REQUEST = 400
    case OK = 200
}
