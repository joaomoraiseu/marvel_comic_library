//
//  TitleDetailViewController.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 18/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import UIKit
import SDWebImage

class TitleDetailViewController: UIViewController {
    
    @IBOutlet weak var bannerImage : UIImageView!
    @IBOutlet weak var coverImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextField : UITextView!
    var comicDetail : Comic?
    
    lazy var buyOptions: BuyOptionsCustomView = {
        let buyOptions = BuyOptionsCustomView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: 200))
        buyOptions.center.x = self.view.center.x
        buyOptions.center.y = self.view.center.y
        buyOptions.delegate = self
        buyOptions.isHidden = true
        buyOptions.layer.zPosition = 20
        return buyOptions
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bannerImage.animationDuration = 10.0
        self.bannerImage.sd_setShowActivityIndicatorView(true)
        self.bannerImage.sd_setIndicatorStyle(.white)
        self.bannerImage.sd_setAnimationImages(with: (comicDetail?.image?.map{$0.url!}) as! [URL])
        self.coverImage.sd_setImage(with: comicDetail?.thumbnail?.url!, completed: nil)
        self.titleLabel.text = comicDetail?.title
        self.view.addSubview(buyOptions)
        self.priceLabel.text = "PRICE : $\(comicDetail!.prices!.first!.price!.rounded(toPlaces: 2).description)"
        self.descriptionTextField.text = comicDetail?.descript
    }
    
    @IBAction func buy_action(){
        buyOptions.isHidden = false
    }
    
    @IBAction func dismiss_action(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch : UITouch = touches.first else{
            return
        }
        if(touch.view != buyOptions){
            buyOptions.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(comicDetail == nil){
            fatalError("Comic com valor nulo")
        }
    }
}
extension TitleDetailViewController: BuyOptionsProtocol{
    func optionPressed(site: String) {
        let busca = site + (comicDetail?.title!)!
        let encodedUrl = busca.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        guard let url = URL(string: encodedUrl!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    

}
