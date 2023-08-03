//
//  UIView+.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/2/23.
//

import UIKit

extension UIView {
    // Function to add subviews to the view
    @discardableResult
    func subviews(_ subviews: UIView...) -> Self {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        return self
    }
    
    // Function to set the height of the view
    @discardableResult
    func height(_ height: CGFloat) -> Self {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    // Function to set the width of the view
    @discardableResult
    func width(_ width: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    // Function to center the view horizontally in its superview
    @discardableResult
    func centerHorizontally() -> Self {
        guard let superview = superview else {
            return self
        }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        return self
    }
    
    // Function to center the view vertically in its superview
    @discardableResult
    func centerVertically() -> Self {
        guard let superview = superview else {
            return self
        }
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        return self
    }
    
    // Function to set the top constraint of the view
    @discardableResult
    func top(_ constant: CGFloat = 0) -> Self {
        guard let superview = superview else {
            return self
        }
        let topConstraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
        topConstraint.isActive = true
        return self
    }
    
    // Function to set the bottom constraint of the view
    @discardableResult
    func bottom(_ constant: CGFloat = 0) -> Self {
        guard let superview = superview else {
            return self
        }
        let bottomConstraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
        bottomConstraint.isActive = true
        return self
    }
    
    // Function to fill the view vertically to its superview
    @discardableResult
    func fillVertically(_ insets: UIEdgeInsets = .zero) -> Self {
        guard let _ = superview else {
            return self
        }
        top(insets.top)
        bottom(insets.bottom)
        return self
    }
    
    // Function to fill the view horizontally to its superview
    @discardableResult
    func fillHorizontally(_ insets: UIEdgeInsets = .zero) -> Self {
        guard let superview = superview else {
            return self
        }
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        return self
    }
    
    // Function to fill the view completely to its superview without any insets
    @discardableResult
    func fillContainer() -> Self {
        guard let superview = superview else {
            return self
        }
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        return self
    }
    
    // Function to set the leading constraint of the view
    @discardableResult
    func left(_ constant: CGFloat = 0) -> Self {
        guard let superview = superview else {
            return self
        }
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        return self
    }
    
    // Function to set the trailing constraint of the view
    @discardableResult
    func right(_ constant: CGFloat = 0) -> Self {
        guard let superview = superview else {
            return self
        }
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        return self
    }
    
}

// Custom properties to represent top and bottom constraints
extension UIView {
    var Top: NSLayoutConstraint? {
        return constraints.first { $0.firstItem as? UIView == self && $0.firstAttribute == .top }
    }
    
    var Bottom: NSLayoutConstraint? {
        return constraints.first { $0.firstItem as? UIView == self && $0.firstAttribute == .bottom }
    }
}

extension UIView {
    
    func loadImageFromDocumentsDirectory(withName name: String) -> UIImage? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent(name)
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image from documents directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    func setupShadow() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }
}
