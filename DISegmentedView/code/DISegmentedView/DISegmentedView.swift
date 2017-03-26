//
//  DISegmentedView.swift
//  DISegmentedView
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import UIKit


/// Dot indicator segment view.
@IBDesignable
open class DISegmentedView: UIControl {
    
    fileprivate var buttons = [UIButton]()
    fileprivate let indicator = UIView()
    fileprivate let titleFont = UIFont.systemFont(ofSize: 17)
    
    /// Currently selected segment button.
    open var selectedIndex = 0 {
        didSet {
            setSelectedIndex(selectedIndex, animated: false)
        }
    }
    
    /// Arrays of the titles for segments. Dynamically update instance for new array of title.
    open var titles: [String] = [String]() {
        didSet {
            selectedIndex = min(titles.count - 1, selectedIndex)
            addButtons()
            setNeedsLayout()
        }
    }
    
    /// Tint color for dot, that indicates selected segment.
    override open var tintColor: UIColor! {
        didSet {
            indicator.backgroundColor = tintColor
        }
    }
    
    /// Diameter of dot, that indicates selected segment.
    @IBInspectable
    open var indicatorWidth: CGFloat = 5 {
        didSet {
            indicator.frame = CGRect(origin: indicator.frame.origin, size: CGSize(width: indicatorWidth, height: indicatorWidth))
            indicator.layer.cornerRadius = indicator.frame.width / 2
            setNeedsLayout()
        }
    }
    
    /// Vertical offset between segment and dot indicator.
    @IBInspectable
    open var indicatorOffset: CGFloat = 7 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// Color of the active segment title.
    @IBInspectable
    open var titleActiveColor: UIColor = UIColor.white {
        didSet {
            for button in buttons {
                button.setTitleColor(titleActiveColor, for: .selected)
            }
        }
    }
    
    /// Color of the inactive segment title.
    @IBInspectable
    open var titleInactiveColor: UIColor = UIColor(white: 150 / 255, alpha: 1) {
        didSet {
            for button in buttons {
                button.setTitleColor(titleInactiveColor, for: UIControlState())
            }
        }
    }
    
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        titles = ["First", "Second", "Third"]
    }
    
    //MARK: - Inits
    /**
     Create an instance of DISegmentedVeiw.
     
     - parameter names: Array of the titles for segment.
     - parameter frame: Frame of the instance.
     
     - returns: Instance of the DISegmentedView.
     */
    public init(names: [String], frame: CGRect = CGRect(x: 0, y: 0, width: 44, height: 44)) {
        self.titles = names
        super.init(frame: frame)
        
        self.configureIndicator()
        self.addButtons()
    }
    
    /**
     Create an instance of DISegmentedVeiw.
     
     - parameter frame: Frame of the instance.
     
     - returns: Instance of the DISegmentedView.
     */
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
    fileprivate func configureIndicator() {
        indicator.frame              = CGRect(x: 0, y: 0, width: indicatorWidth, height: indicatorWidth)
        indicator.clipsToBounds      = true
        indicator.backgroundColor    = tintColor
        indicator.layer.cornerRadius = indicator.frame.width / 2
        
        addSubview(indicator)
    }
    
    fileprivate func addButtons() {
        for button in buttons {
            button.removeFromSuperview()
        }

        buttons = titles.map() { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: UIControlState())
            button.setTitleColor(titleInactiveColor, for: UIControlState())
            button.setTitleColor(titleActiveColor, for: .selected)
            button.tintColor = UIColor.clear
            button.titleLabel?.font = titleFont
            button.addTarget(self, action: #selector(DISegmentedView.selectButton(_:)), for: .touchUpInside)
            
            addSubview(button)
            
            return button
        }
    }
    
    open override func layoutSubviews() {
        guard !buttons.isEmpty else { return }
        
        let buttonWidth = frame.width / CGFloat(buttons.count)
        
        for (index, button) in buttons.enumerated() {
            button.frame = CGRect(x: CGFloat(index) * buttonWidth, y: 0, width: buttonWidth, height: frame.height)
        }
        
        buttons[selectedIndex].isSelected = true
        indicator.center = CGPoint(x: buttons[selectedIndex].center.x, y: frame.height - indicatorOffset)
    }
    
    //MARK: - Change state
    internal func selectButton(_ sender: UIButton) {
        setSelectedIndex(buttons.index(of: sender)!, animated: true)
    }
    
    /**
     Set the current selected segment.
     
     - parameter index:    Index of the selected index.
     - parameter animated: `true` to animate changing of the segement property.
     */
    open func setSelectedIndex(_ index: Int, animated: Bool) {
        guard selectedIndex != index else { return }
        
        selectedIndex = index
        sendActions(for: .valueChanged)
        
        for button in buttons {
            button.isSelected = false
        }
        self.buttons[index].isSelected = true
        
        UIView.animate(withDuration: animated ? 0.4 : 0, delay: 0, usingSpringWithDamping: 0.68, initialSpringVelocity: 10, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.indicator.center = CGPoint(x: self.buttons[index].center.x, y: self.indicator.center.y)
            }, completion: nil)
        
    }
}
