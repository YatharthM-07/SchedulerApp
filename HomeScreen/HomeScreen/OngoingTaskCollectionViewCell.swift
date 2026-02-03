import UIKit

class OngoingTaskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var ongoingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var markDoneButton: UIButton!
    @IBOutlet weak var snoozeButton: UIButton!
    @IBOutlet weak var illustrationImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Card appearance – light gray, rounded, subtle shadow
        cardView.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = true

        // Shadow on the cell itself (not clipped by the card view)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
        
        // "Ongoing" pill: dark gray background, white text
        ongoingLabel.textColor = .black
        ongoingLabel.textAlignment = .center
        ongoingLabel.layer.cornerRadius = 12
        ongoingLabel.layer.masksToBounds = true
        ongoingLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        // Style title label
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .black
        
        // Style time label (clock-style text)
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        timeLabel.textColor = .secondaryLabel
        
        // Mark Done – blue, white text
        markDoneButton.backgroundColor = .systemBlue
        markDoneButton.setTitleColor(.white, for: .normal)
        markDoneButton.layer.cornerRadius = 10
        markDoneButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        // Snooze – light gray background, dark text (no border)
        snoozeButton.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        snoozeButton.setTitleColor(.darkGray, for: .normal)
        snoozeButton.layer.cornerRadius = 10
        snoozeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }

    func configure(task: Task) {
        titleLabel.text = task.title
        timeLabel.text = task.time
        ongoingLabel.text = "Ongoing"
    }
}

