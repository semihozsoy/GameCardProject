//
//  PlatformsView.swift
//  FinalProject
//
//  Created by Semih Özsoy on 6.06.2021.
//

import UIKit

  final class PlatformsView: UIView{
    @IBOutlet weak var platformsLabel: UILabel!
  
    
    init(title:String,titleColor:UIColor = .black,titleFont:UIFont = .regular(10)) {
        self.init()
        platformsLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
 
    func fromNib(){
         let contentView = Bundle.main.loadNibNamed("PlatformsView",owner: self,options: nil)![0] as! UIView
        addSubview(contentView)
        contentView.frame = self.bounds
        
        }
    
    }
    
    


