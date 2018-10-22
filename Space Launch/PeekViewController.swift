//
//  PeekViewController.swift
//  Space Launch
//
//  Created by Alcides Junior on 22/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class PeekViewController: UIViewController {
    
    @IBOutlet weak var peekImage: UIImageView!
    @IBOutlet weak var peekLabel: UILabel!
    var image : UIImage?
    var label : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        peekImage.image = image
        peekLabel.text = label
    }
    
}
