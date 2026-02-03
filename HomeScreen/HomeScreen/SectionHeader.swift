//
//  SectionHeader.swift
//  HomeScreen
//
//  Created by GEU on 31/01/26.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    private let seeAllLabel = UILabel()
    private var didSetupLayout = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if !didSetupLayout {
            didSetupLayout = true
            setupLayout()
        }
    }
    
    private func setupLayout() {
        // Section title: bold, black, top-aligned
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .black
        
        // "See all >" on the right, blue
        seeAllLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllLabel.text = "See all >"
        seeAllLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        seeAllLabel.textColor = .systemBlue
        seeAllLabel.isHidden = true
        
        addSubview(seeAllLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            seeAllLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            seeAllLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
        
        // Show "See all" for both "Up Next" and "Missed Tasks" sections
        seeAllLabel.isHidden = (title != "Up Next" && title != "Missed Tasks")
    }
}
