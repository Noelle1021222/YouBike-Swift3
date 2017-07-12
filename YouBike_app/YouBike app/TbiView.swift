//
//  TbiView.swift
//  week_2_part_3
//
//  Created by 許雅筑 on 2016/9/2.
//  Copyright © 2016年 許雅筑. All rights reserved.
//

import UIKit

 class TbiView: UIView {

    
    @IBOutlet var view: UIView!
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
        UINib(nibName: "TbiView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        //使view符合storyboard
        view.frame = self.bounds

    }
    @IBOutlet weak var bikeAmountLabel: UILabel!
    @IBOutlet weak var stationPositionLabel: UILabel!
    
    @IBOutlet weak var stationNameLabel: UILabel!

    @IBOutlet weak var iconPosition: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        iconPosition.tintColor = UIColor(red: 160/255, green: 98/255, blue: 90/255, alpha: 1)
        
        
    }


}
