//
//  ExtensionUIViewController.swift
//  Space Launch
//
//  Created by Alcides Junior on 23/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

extension UIView{
    func spinner(_ loading: UIActivityIndicatorView){
        loading.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loading)
        loading.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
