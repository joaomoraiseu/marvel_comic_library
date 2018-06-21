//
//  BuyOptionsCustomView
//
//
//  Created by João  Pedro on 20/06/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

protocol BuyOptionsProtocol {
    func optionPressed(site : String)
}

class BuyOptionsCustomView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    var delegate : BuyOptionsProtocol?
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                        UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 6
        self.delegate? = self as! BuyOptionsProtocol
    }
    
    @IBAction func btClose(){
        self.isHidden = true
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func saraiva_action(){
        self.delegate?.optionPressed(site: "https://busca.saraiva.com.br/busca?q=")
    }
    
    @IBAction func amazon_action(){
        self.delegate?.optionPressed(site: "https://www.amazon.com.br/s?k=")
    }
    
}
