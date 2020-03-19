//
//  MyTableViewCell.swift
//  TableTest
//
//  Created by Andrew Zinoviev on 3/19/20.
//  Copyright © 2020 Andrew Zinoviev. All rights reserved.
//

import UIKit

@IBDesignable
class MyTableViewCell: UITableViewCell {
    
    @IBInspectable var cornerRadius:CGFloat = 5.0;
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var stackLayout: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = cornerRadius;
    }
    
//    func xibSetup() {
//        guard let view = loadViewFromNib() else { return }
//        view.frame = bounds
//        view.autoresizingMask =
//            [.flexibleWidth, .flexibleHeight]
//        addSubview(view)
//        cellView = view
//    }
//
//    func loadViewFromNib() -> UIView? {
//        //        guard let nibName = nibName else { return nil }
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(
//            withOwner: self,
//            options: nil).first as? UIView
//    }
//
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        bgView.layer.cornerRadius = cornerRadius;
        stackLayout.prepareForInterfaceBuilder()
    }
}
