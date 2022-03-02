//
//  UIViewController+Extensions.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import SwiftyJSON


typealias BasicCompletion = ((_ statusCode: Int?, _ isSuccess: Bool, _ data: JSON?, _ error: String?) -> Void)

class BasicResponse: NSObject {

    var success: Bool
    var payload: JSON?
    var message: String?
    
    init(jsonResponse: JSON, statusCode: Int) {

        success = statusCode == 200
        payload = JSON(jsonResponse["response"])
        message = jsonResponse["message"].string
    }
}
