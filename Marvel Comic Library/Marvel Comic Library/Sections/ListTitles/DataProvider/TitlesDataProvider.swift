//
//  StationsDataProvier.swift
//
//  Created by João  Pedro on 20/06/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

protocol TitlesDataProviderProtocol {
    func getTitles(completion: @escaping(Bool,[Comic])-> Void?)
}

class TitlesDataProvider {
    var titlesDomain: TitlesDomain?
    
    func getTitles(completion: @escaping(Bool,[Comic])-> Void?){
        self.titlesDomain?.getTitles(completion: { (success,list) -> Void? in
            completion(success,list)
        })
    }
}
