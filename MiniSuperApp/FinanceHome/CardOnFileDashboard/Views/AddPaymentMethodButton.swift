//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/15.
//

import UIKit

final class AddpaymentMethodButton: UIControl {
    
    private let plushIcon: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
            )
        )
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(plushIcon)
        
        NSLayoutConstraint.activate([
            plushIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plushIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
