//
//  AddButtonView.swift
//  FancyAnimation
//
//  Created by Salim Braksa on 2/26/17.
//  Copyright © 2017 Salim Braksa. All rights reserved.
//

import UIKit

@IBDesignable
class AddButtonView: UIView {
    
    @IBOutlet weak var addButton: UIButton!
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        
        clipsToBounds = true
        contentView = loadViewFromNib()
        contentView!.frame = bounds
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView!)
        
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
        
    }
    
}
