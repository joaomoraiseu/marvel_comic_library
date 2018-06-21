//
//  ComicListTableViewCell.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 18/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import UIKit

protocol ComicListTableViewProtocol {
    func didSelectItem(index:Int,indexPath: IndexPath)
}

class ComicListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var title: UILabel!
    let collectionViewLayout = UICollectionViewFlowLayout()
    fileprivate var comics = [Comic]()
    var delegate : ComicListTableViewProtocol?
    var index : Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        registerCell()
    }
    
    func configure(letter: Character,comics: [Comic],index:Int){
        self.comics = comics
        self.title.text = "#\(letter)"
        self.index = index
        self.collectionView.reloadData()
    }
    
    private func registerCell(){
        collectionView.register(UINib(nibName: String(describing: ComicCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ComicCollectionViewCell.self))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension ComicListTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ComicCollectionViewCell.self), for: indexPath) as! ComicCollectionViewCell
        cell.comicTitle.text = self.comics[indexPath.row].title
        cell.comicAuthor.text = self.comics[indexPath.row].descript
        cell.comicImage.sd_setShowActivityIndicatorView(true)
        cell.comicImage.sd_setIndicatorStyle(.white)
        cell.comicImage.sd_setImage(with: self.comics[indexPath.row].thumbnail?.url!, placeholderImage:nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(index: index!, indexPath: indexPath)
    }
}
