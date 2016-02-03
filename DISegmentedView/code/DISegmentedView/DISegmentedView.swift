//
//  DISegmentedView.swift
//  DISegmentedView
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit


@IBDesignable
public class DISegmentedView: UIControl {
    
    private var buttons = [UIButton]()
    private let indicator = UIView()
    private let titleFont = UIFont.systemFontOfSize(17)
    
    public var selectedIndex = 0 {
        didSet {
            setSelectedIndex(selectedIndex, animated: false)
        }
    }
    
    public var titles: [String] = [String]() {
        didSet {
            addButtons()
            setNeedsLayout()
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            indicator.backgroundColor = tintColor
        }
    }
    
    @IBInspectable
    public var indicatorWidth: CGFloat = 5 {
        didSet {
            indicator.frame = CGRect(origin: indicator.frame.origin, size: CGSize(width: indicatorWidth, height: indicatorWidth))
            indicator.layer.cornerRadius = indicator.frame.width / 2
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var indicatorOffset: CGFloat = 7 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var titleActiveColor: UIColor = UIColor.whiteColor() {
        didSet {
            for button in buttons {
                button.setTitleColor(titleActiveColor, forState: .Selected)
            }
        }
    }
    
    @IBInspectable
    public var titleInactiveColor: UIColor = UIColor(white: 150 / 255, alpha: 1) {
        didSet {
            for button in buttons {
                button.setTitleColor(titleInactiveColor, forState: .Normal)
            }
        }
    }
    
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        titles = ["First", "Second", "Third"]
    }
    
    //MARK: - Inits
    public init(names: [String]) {
        self.titles = names
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        self.configureIndicator()
        self.addButtons()
    }
    
    override public init(frame: CGRect) {
        self.titles = [String]()
        super.init(frame: frame)
        
        configureIndicator()
        addButtons()
    }

    required public init?(coder aDecoder: NSCoder) {
        self.titles = [String]()
        super.init(coder: aDecoder)
        
        configureIndicator()
        addButtons()
    }
    
    //MARK: - Configure
    private func configureIndicator() {
        indicator.frame              = CGRect(x: 0, y: 0, width: indicatorWidth, height: indicatorWidth)
        indicator.clipsToBounds      = true
        indicator.backgroundColor    = tintColor
        indicator.layer.cornerRadius = indicator.frame.width / 2
        
        addSubview(indicator)
    }
    
    private func addButtons() {
        for button in buttons {
            button.removeFromSuperview()
        }

        buttons = titles.map() { title in
            let button = UIButton(type: .System)
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(titleInactiveColor, forState: .Normal)
            button.setTitleColor(titleActiveColor, forState: .Selected)
            button.tintColor = UIColor.clearColor()
            button.titleLabel?.font = titleFont
            button.addTarget(self, action: "selectButton:", forControlEvents: .TouchUpInside)
            
            addSubview(button)
            
            return button
        }
    }
    
    public override func layoutSubviews() {
        guard !buttons.isEmpty else { return }
        
        let buttonWidth = frame.width / CGFloat(buttons.count)
        
        for (index, button) in buttons.enumerate() {
            button.frame = CGRect(x: CGFloat(index) * buttonWidth, y: 0, width: buttonWidth, height: frame.height)
        }
        
        buttons[selectedIndex].selected = true
        indicator.center = CGPoint(x: buttons[selectedIndex].center.x, y: frame.height - indicatorOffset)
    }
    
    //MARK: - Change state
    public func selectButton(sender: UIButton) {
        setSelectedIndex(buttons.indexOf(sender)!, animated: true)
    }
    
    public func setSelectedIndex(index: Int, animated: Bool) {
        guard selectedIndex != index else { return }
        
        selectedIndex = index
        sendActionsForControlEvents(.ValueChanged)
        
        for button in buttons {
            button.selected = false
        }
        self.buttons[index].selected = true
        
        UIView.animateWithDuration(animated ? 0.4 : 0, delay: 0, usingSpringWithDamping: 0.68, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: { () -> Void in
            self.indicator.center = CGPoint(x: self.buttons[index].center.x, y: self.indicator.center.y)
            }, completion: nil)
        
    }
}
