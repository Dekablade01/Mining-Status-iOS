//
//  Alamofire+RxSwift.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Request: ReactiveCompatible {}

extension Reactive where Base: DataRequest {
    
    func responseJSON() -> Observable<Any> {
        return Observable.create { observer in
            let request = self.base.responseJSON { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create(with: request.cancel)
        }
    }
}
