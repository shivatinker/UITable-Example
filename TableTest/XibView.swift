//
//  XibView.swift
//  TableTest
//
//  Created by Andrew Zinoviev on 3/19/20.
//  Copyright © 2020 Andrew Zinoviev. All rights reserved.
//

import UIKit

@IBDesignable
class XibView: UIView {
    
    var nibName:String = "CusView"
    var cellView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
         view.autoresizingMask =
                    [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        cellView = view
    }

    func loadViewFromNib() -> UIView? {
//        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
                    withOwner: self,
                    options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        cellView?.prepareForInterfaceBuilder()
    }
    
}
