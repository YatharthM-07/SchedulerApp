//
//  ViewController.swift
//  HomeScreen
//
//  Created by GEU on 31/01/26.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    var ongoingTask: Task?
       var upNextTasks: [Task] = []
       var missedTasks: [Task] = []

       // Simple header views for "Today" and the date, plus a profile circle.
       private let headerContainerView = UIView()
       private let titleLabel = UILabel()
       private let subtitleLabel = UILabel()
       private let profileButton = UIButton(type: .system)
       private let headerHeight: CGFloat = 110

       override func viewDidLoad() {
           super.viewDidLoad()
           homeCollectionView.backgroundColor = .systemGroupedBackground
           view.backgroundColor = .systemGroupedBackground

           setupData()
           registerCells()

           homeCollectionView.dataSource = self
           homeCollectionView.delegate = self
           setupHeader()
           homeCollectionView.setCollectionViewLayout(generateLayout(), animated: false)
       }

       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

           // Make the collection view content start below the header.
           homeCollectionView.contentInset.top = headerHeight
           homeCollectionView.scrollIndicatorInsets.top = headerHeight
       }

       // MARK: - Setup Data
       func setupData() {
           ongoingTask = Task(title: "Team Meeting", time: "9:00-11:00", iconStyle: "purple")

           upNextTasks = [
               Task(title: "Project Sync", time: "9:00-11:00", iconStyle: "blue"),
               Task(title: "Team Meeting", time: "9:30-10:00", iconStyle: "purple"),
               Task(title: "Prepare keynote", time: "12:00-13:00", iconStyle: "blue")
           ]

           missedTasks = [
               Task(title: "Leetcode", time: "9:00-9:30", iconStyle: "green"),
               Task(title: "Revision", time: "18:00-19:00", iconStyle: "blue"),
               Task(title: "Workout", time: "19:00-20:00", iconStyle: "green")
           ]
       }

       // MARK: - Register Cells
       func registerCells() {

           homeCollectionView.register(
               UINib(nibName: "OngoingTaskCollectionViewCell", bundle: nil),
               forCellWithReuseIdentifier: "ongoing_cell"
           )

           homeCollectionView.register(
               UINib(nibName: "UpNextCollectionViewCell", bundle: nil),
               forCellWithReuseIdentifier: "upnext_cell"
           )

           homeCollectionView.register(
               UINib(nibName: "MissedTaskCollectionViewCell", bundle: nil),
               forCellWithReuseIdentifier: "missed_cell"
           )

           homeCollectionView.register(
               UINib(nibName: "SectionHeader", bundle: nil),
               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
               withReuseIdentifier: "header_view"
           )
       }

       // MARK: - Header ("Today" + date)
       private func setupHeader() {
           headerContainerView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(headerContainerView)

           NSLayoutConstraint.activate([
               headerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
               headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               headerContainerView.heightAnchor.constraint(equalToConstant: headerHeight)
           ])

           headerContainerView.backgroundColor = .clear

           // Title: "Today"
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           titleLabel.text = "Today"
           titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
           titleLabel.textColor = .label

           // Subtitle: current date, e.g. "Thursday, 4 Dec"
           subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
           let formatter = DateFormatter()
           formatter.dateFormat = "EEEE, d MMM"
           subtitleLabel.text = formatter.string(from: Date())
           subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
           subtitleLabel.textColor = .secondaryLabel

           // Profile circle on the right (yellow-orange per design).
           profileButton.translatesAutoresizingMaskIntoConstraints = false
           profileButton.backgroundColor = UIColor(red: 1.0, green: 0.75, blue: 0.4, alpha: 1.0)
           profileButton.layer.cornerRadius = 20
           profileButton.layer.masksToBounds = true

           headerContainerView.addSubview(titleLabel)
           headerContainerView.addSubview(subtitleLabel)
           headerContainerView.addSubview(profileButton)

           NSLayoutConstraint.activate([
               titleLabel.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
               titleLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),

               subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
               subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
               subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: headerContainerView.bottomAnchor),

               profileButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
               profileButton.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
               profileButton.widthAnchor.constraint(equalToConstant: 40),
               profileButton.heightAnchor.constraint(equalToConstant: 40)
           ])
       }
   }
extension HomeViewController {

    func generateLayout() -> UICollectionViewLayout {

        return UICollectionViewCompositionalLayout { sectionIndex, _ in

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            )

            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )

            let section: NSCollectionLayoutSection

            switch sectionIndex {

            case 0:
                section = self.bigCardSection(height: 200)
                section.boundarySupplementaryItems = []

            case 1:
                section = self.horizontalScrollSection(height: 140)
                section.boundarySupplementaryItems = [header]

            case 2:
                section = self.horizontalScrollSection(height: 120)
                section.boundarySupplementaryItems = [header]

            default:
                section = self.verticalListSection(height: 100)
            }

            return section
        }
    }

    func bigCardSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 24, leading: 16, bottom: 24, trailing: 16
        )
        
        return section
    }
    
    func verticalListSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 16, trailing: 16
        )
        
        return section
    }
    
    /// Two-column grid for the "Missed Tasks" section, like the reference design.
    func twoColumnSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 8
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 24, trailing: 16
        )
        
        return section
    }
    
    /// Horizontal scrolling section for "Up Next" tasks
    func horizontalScrollSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Each card takes about 75% of screen width for horizontal scrolling
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.75),
            heightDimension: .absolute(height)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 24, trailing: 16
        )
        
        return section
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return ongoingTask == nil ? 0 : 1
        case 1: return upNextTasks.count
        case 2: return missedTasks.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ongoing_cell",
                for: indexPath
            ) as! OngoingTaskCollectionViewCell
            cell.configure(task: ongoingTask!)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "upnext_cell",
                for: indexPath
            ) as! UpNextCollectionViewCell
            cell.configure(task: upNextTasks[indexPath.row])
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "missed_cell",
                for: indexPath
            ) as! MissedTaskCollectionViewCell
            cell.configure(task: missedTasks[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        // ✅ IMPORTANT: guard the kind
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header_view",
            for: indexPath
        ) as! SectionHeader

        if indexPath.section == 1 {
            header.configure(with: "Up Next")
        } else if indexPath.section == 2 {
            header.configure(with: "Missed Tasks")
        }

        return header
    }

}
extension HomeViewController: UICollectionViewDelegate {
    
}

