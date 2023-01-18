//
//  RatingControl.swift
//  MyPlaces
//
//  Created by Matvei Bykadorov on 14.01.2023.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    private var ratingButtons = Array<UIButton>()
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
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
        guard let index = ratingButtons.firstIndex(of: button) else {return}
        let selectedRating  = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    // MARK: Private Methods
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 46.0))
        var configFilledStar = UIImage.SymbolConfiguration(paletteColors: [.systemCyan])
        configFilledStar = configFilledStar.applying(config)
        let filledStar = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(config)
        let emptyStar = UIImage(systemName: "star")?.applyingSymbolConfiguration(config)
        let highlightedStar = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(configFilledStar)
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button: )), for: .touchUpInside)
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
