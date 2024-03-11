//
//  BorderSquareCollectionCell.swift
//  OMG-Test
//
//  Created by Andrey on 11.03.2024.
//

import UIKit

class BorderSquareCollectionCell: UICollectionViewCell {
    
    // MARK: - Public
    static let identidier = "BorderSquareCollectionCell"
    
    // MARK: - Private
    private lazy var numberLabel: UILabel = {
        let label = UILabel().forAutoLayout()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(number: Int) {
        configureUI()
        numberLabel.text = String(number)
    }
}

private extension BorderSquareCollectionCell {
    func configureUI() {
        contentView.backgroundColor = .black
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.addSubview(numberLabel)
        numberLabel.setSimpleConstraints()
    }
}

extension BorderSquareCollectionCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateStart()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateStop()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateStop()
    }
}

