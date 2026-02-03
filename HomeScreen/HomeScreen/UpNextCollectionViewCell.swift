//
//  UpNextCollectionViewCell.swift
//  HomeScreen
//
//  Created by GEU on 31/01/26.
//

import UIKit

class UpNextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    // These will be connected from the XIB to match the visual design.
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Base card look – light gray, rounded
        contentView.backgroundColor = .clear
        cardView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true

        // Icon circle – color set in configure(iconStyle:)
        iconView.layer.cornerRadius = 20
        iconView.layer.masksToBounds = true

        // Typography
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black

        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        timeLabel.textColor = .secondaryLabel

        // Soft shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }

    func configure(task: Task) {
        titleLabel.text = task.title
        timeLabel.text = task.time
        // Blue or purple tint for icon circle (book / people)
        switch task.iconStyle {
        case "purple":
            iconView.backgroundColor = UIColor(red: 0.6, green: 0.4, blue: 0.9, alpha: 0.25)
        case "green":
            iconView.backgroundColor = UIColor(red: 0.2, green: 0.75, blue: 0.4, alpha: 0.25)
        default:
            iconView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        }
    }
}
