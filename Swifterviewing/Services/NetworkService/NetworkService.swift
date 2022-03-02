//
//  UIViewController+Extensions.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Alamofire
import Reachability
import SwiftyJSON

///
class NetworkService {
    
    // MARK: - Variables
    
    private var reachability: Reachability?
    private(set) var isReachable: Bool = false
    private let notificationService: NotificationService
    
    let timeoutIntervalForRequest = 60.0
    let timeoutIntervalForResource = 120.0
    
    // MARK: - Life Cycle Methods
    
    init(notificationService: NotificationService) {
        
        self.notificationService = notificationService
        configureReachablity()
    }
    
    // MARK: - Configuration Methods
    
    @objc func reachabilityChanged(_ notification: Notification) {
        
        guard let reachability = notification.object as? Reachability, reachability.connection != .unavailable else {
            isReachable = false
            // Show Internet alert/View
            notificationService.showInternetAlert()
            return
        }
        isReachable = true
    }
    
    func configureReachablity() {
        // Reachability
        do {
            try  reachability = Reachability.init()
        } catch { print("cant access") }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch { print("cant access") }
    }
    
    // MARK: - Alamofire Configuration
    
    func setAlamofireDefaultConfiguration() {
        
        Alamofire.Session.default.session.configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        Alamofire.Session.default.session.configuration.timeoutIntervalForResource = timeoutIntervalForResource
    }
    
    /// Custom network request method
    /// - Parameters:
    ///   - parameters: body
    ///   - headerParameter: custom header paramets
    ///   - serverUrl: base url
    ///   - apiPath: endpoints
    ///   - httpMethod: http method type
    ///   - queue: defaults to nil, mention required queue
    ///   - success: success block
    ///   - failure: failure block
    /// - Returns: return request with specified input parameters
    @discardableResult func request(parameters: Parameters?,
                                    headerParameter: HTTPHeaders? = nil,
                                    serverUrl: String = Network.baseURL,
                                    apiPath: String,
                                    httpMethod: HTTPMethod,
                                    queue: DispatchQueue? = nil,
                                    success: @escaping(_ statusCode: Int, _ response: [String: Any]) -> Void,
                                    failure: @escaping(_ statusCode: Int, _ error: Error?) -> Void) -> DataRequest {
        
        setAlamofireDefaultConfiguration()
        // Set path
        let completeURL = serverUrl + apiPath
        let header = headerParameter == nil ? ["Content-Type": "application/json"] : headerParameter
        let request = AF.request(completeURL, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON(queue: queue ?? .main) { response in
            if let headers = response.response?.allHeaderFields as? [String: String] {
                if let header = headers["x-access-token"] { print(header) }
            }
            switch response.result {
            case .success:
                guard let code = response.response?.statusCode,
                      let response = response.value as? [Any] else {
                    failure(response.response?.statusCode ?? 401, response.error)
                    return
                }
                success(code, ["response": response])
            case .failure:
                
                guard let code = response.response?.statusCode else {
                    failure(response.response?.statusCode ?? 401, response.error)
                    return
                }
                failure(code, response.error)
            }
        }
        return request
    }
}
