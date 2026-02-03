//
//  MissedTaskCollectionViewCell.swift
//  HomeScreen
//
//  Created by GEU on 31/01/26.
//

import UIKit

class MissedTaskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var rescheduleButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .clear

        // Card – light gray, rounded, same as Up Next
        cardView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        // Icon circle – color set in configure
        iconView.layer.cornerRadius = 20
        iconView.layer.masksToBounds = true

        // Typography
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1

        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLabel.textColor = .secondaryLabel
        timeLabel.numberOfLines = 1
        
        // Reschedule – blue, top-right in card
        rescheduleButton.setTitle("Reschedule", for: .normal)
        rescheduleButton.backgroundColor = .systemBlue
        rescheduleButton.setTitleColor(.white, for: .normal)
        rescheduleButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        rescheduleButton.layer.cornerRadius = 8
        rescheduleButton.layer.masksToBounds = true
        
        // Card shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
    }

    func configure(task: Task) {
        titleLabel.text = task.title
        timeLabel.text = task.time
        // Green (pencil) or blue (book) for missed task icons
        switch task.iconStyle {
        case "green":
            iconView.backgroundColor = UIColor(red: 0.2, green: 0.75, blue: 0.4, alpha: 0.25)
        default:
            iconView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        }
    }
}
