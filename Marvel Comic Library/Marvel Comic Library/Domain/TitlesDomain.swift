//
//  PaymentsDomain.swift
//  AbasteceAi
//
//  Copyright © 2018. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

class TitlesDomain: TitlesDataProviderProtocol {
 
    
    let apiCallHelper = ApiCallHelper()
   
    func getTitles(completion: @escaping (Bool,[Comic]) -> Void?) {
            ProgressHud.shared.show()
            let dict: KeyDict = apiCallHelper.getKeys()
            let baseMarvelURL = apiCallHelper.getMainEndpoint()
            let ts = NSDate().timeIntervalSince1970.description
            
            let params = [
                "apikey": dict.publicKey!,
                "ts": ts,
                "hash": (ts + dict.privateKey! + dict.publicKey!).md5(),
                "orderBy": "title",
                "limit" : 100,
                "offset" : 0,
                ] as [String : Any]
        Alamofire.request(baseMarvelURL,parameters: params).responseJSON { (data) in
            do {
                var result = ""
                 ProgressHud.shared.hide()
                if data.result.value == nil || data.result.value is NSNull {
                    completion(false,[Comic]())
                } else {
                    var responseCode = data.response?.statusCode
                        if responseCode == 200 {
                            do {
                                result = try! (String(data: JSONSerialization.data(withJSONObject: data.result.value ?? "", options: .prettyPrinted), encoding: .utf8) ?? "").replacingOccurrences(of: "\n", with: "")
                                let comicList = try JSONDecoder().decode(ApiCallModel.self, from: result.data(using: .utf8)!)
                                return completion(true,(comicList.data?.comics)!)!
                            } catch _ {
                                completion(false, [Comic]())
                            }
                        }else { completion(false, [Comic]())}
                    }
            }
        }
    }
}
