//
//  ListTitlesViewController.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 18/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import UIKit

class ListTitlesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var comics = [OrdenedComics]()
    var presenter = TitlesPresenter(dataProvider: TitlesDomain())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.presenter.delegate = self
        self.presenter.getTitles()
        registerCell()
    }

    private func registerCell(){
        self.tableView.register(UINib(nibName: String(describing: ComicListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ComicListTableViewCell.self))
    }
}

extension ListTitlesViewController: ComicListTableViewProtocol{
    
    func didSelectItem(index: Int, indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ListTitles", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TitleDetailViewController.self)) as! TitleDetailViewController
        controller.comicDetail = self.comics[index].comics?[indexPath.row]
        self.present(controller, animated: true, completion: nil)
    }
}

extension ListTitlesViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ComicListTableViewCell.self)) as! ComicListTableViewCell
        cell.delegate = self
        cell.configure(letter: self.comics[indexPath.row].key!, comics: self.comics[indexPath.row].comics!, index: indexPath.row)
        return cell
    }
}

extension ListTitlesViewController: TitlesPresenterProtocol{
    func returnGetTiles(success: Bool, list: [Comic]) {
        if(success){
            let groupedComics = Dictionary(grouping: list, by: { $0.orderLetter! })
            for (key, value) in groupedComics {
                self.comics.append(OrdenedComics(key: key, comics: value))
            }
            self.tableView.reloadData()
        }
    }
}

fileprivate class OrdenedComics{
    
    var key: Character?
    var comics: [Comic]?
    
    init(key:Character,comics:[Comic]){
        self.key = key
        self.comics = comics
    }
}
