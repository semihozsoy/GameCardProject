//
//  UICollectionViewCell+Extension.swift
//  FinalProject
//
//  Created by Semih Özsoy on 31.05.2021.
//

import UIKit


extension UICollectionViewCell {
    static var identifier: String {
        return String(describing:self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
