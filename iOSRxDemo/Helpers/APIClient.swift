//
//  APIClient.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Alamofire
import RxSwift

enum ApiError: Error {
    
    /// Status code 403
    case forbidden
    /// Status code 404
    case notFound
    /// Status code 409
    case conflict
    /// Status code 500
    case internalServerError
}

final class APIClient: NSObject {
    
    /// The request function to get results in an Observable
    static func request<T: APIRequest> (_ request: T) -> Observable<T.Response> {
        
        let urlRequest = request.makeURLRequest()
        
        // Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T.Response>.create { observer in
            // Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlRequest).responseDecodable { (response: DataResponse<T.Response>) in
                // Check the result from Alamofire's response and check if it's a success or a failure
                switch response.result {
                case .success(let value):
                    // Everything is fine, return the value in onNext
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    // Something went wrong, switch on the status code and return the error
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            // Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
