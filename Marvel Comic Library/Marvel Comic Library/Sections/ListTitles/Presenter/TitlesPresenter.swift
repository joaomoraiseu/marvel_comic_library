//
//  StationsPresenter.swift
//
//  Created by João  Pedro on 20/06/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

protocol TitlesPresenterProtocol {
    func returnGetTiles(success: Bool,list: [Comic])
}

class TitlesPresenter {
    
    var delegate : TitlesPresenterProtocol?
    var dataProvider : TitlesDataProviderProtocol?
    
    init(dataProvider: TitlesDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func getTitles(){
        self.dataProvider?.getTitles(completion: { (success,list) -> Void? in
            self.delegate?.returnGetTiles(success: success,list: list)
        })
    }

}
