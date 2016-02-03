//
//  ViewController.swift
//  DISegmentedView
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var segmentView: DISegmentedView!

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentView.titles = ["first", "second", "third"]
    }
    
    @IBAction func changeValue(sender: DISegmentedView) {
        print(sender.selectedIndex)
    }
}

