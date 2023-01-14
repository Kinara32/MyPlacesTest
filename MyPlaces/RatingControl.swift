//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Matvei Bykadorov on 14.01.2023.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    private var ratingButtons = Array<UIButton>()
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    var rating = 0
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed 🙋🏿‍♂️")
    }
    
    // MARK: Private Methods
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            button.backgroundColor = .red
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button: )), for: .touchUpInside)
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
}
