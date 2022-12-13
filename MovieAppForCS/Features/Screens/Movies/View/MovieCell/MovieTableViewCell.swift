//
//  MovieTableViewCell.swift
//  MovieAppForCS
//
//  Created by Berkan Korkmaz on 28.11.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieTableViewCell: UITableViewCell {

// MARK: - UI Elements
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = Constant.UITestIdentifier.MovieTableViewCell.movieCellImageView
        return imageView
    }()

    private let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.accessibilityIdentifier = Constant.UITestIdentifier.MovieTableViewCell.movieCellTitleLabel
        return label
    }()

    private let cellStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.accessibilityIdentifier = Constant.UITestIdentifier.MovieTableViewCell.movieCellStarImageView
        return imageView
    }()

    private let cellAverageVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.accessibilityIdentifier = Constant.UITestIdentifier.MovieTableViewCell.movieCellAverageVoteLabel
        return label
    }()

    private let cellReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .systemGray4.withAlphaComponent(0.3)
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 0.2
        label.textAlignment = .center
        label.clipsToBounds = true
        label.accessibilityIdentifier = Constant.UITestIdentifier.MovieTableViewCell.movieCellReleaseDateLabel
        return label
    }()

    private let cellToDetailButton: CustomButton = CustomButton(color: .systemBlue, title: "", systemImageName: "arrow.right", identifier: Constant.UITestIdentifier.MovieTableViewCell.movieCellDirectButton)

// MARK: - Enums
    enum Identifier: String {
        case movieTableViewCell = "tableViewCellIdentifier"
    }

// MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Functions
    func configure() {
        addUIElements()
        drawDesign()
        makeCellToDetailButton()
        makeImageView()
        makeTitleLabel()
        makeStarImageView()
        makeAverageVoteLabel()
        makeReleaseDateLabel()
    }

    func drawDesign() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBackground.cgColor
    }

    func addUIElements() {
        addSubview(cellToDetailButton)
        addSubview(cellImageView)
        addSubview(cellTitleLabel)
        addSubview(cellStarImageView)
        addSubview(cellAverageVoteLabel)
        addSubview(cellReleaseDateLabel)
    }

    func saveModel(model: Result) {
        cellImageView.kf.setImage(with: URL(string: Constant.ServiceEndPoints.BASE_IMAGE_URL.rawValue + (model.posterPath ?? "")))
        cellTitleLabel.text = model.title
        cellAverageVoteLabel.text = String(describing: model.voteAverage ?? 0.0)
        cellReleaseDateLabel.text = String((model.releaseDate?.split(separator: "-").first) ?? "")
    }
}

// MARK: - SnapKit
extension MovieTableViewCell {

    func makeImageView() {
        cellImageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(110)
            make.top.leading.bottom.equalTo(contentView).inset(15)
        }
    }

    func makeTitleLabel() {
        cellTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImageView.snp.trailing).offset(15)
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview()
        }
    }

    func makeStarImageView() {
        cellStarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.leading.equalTo(cellImageView.snp.trailing).offset(15)
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(12)

        }
    }

    func makeAverageVoteLabel() {
        cellAverageVoteLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellStarImageView.snp.trailing).offset(2)
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(12)
        }
    }

    func makeReleaseDateLabel() {
        cellReleaseDateLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(25)
            make.leading.equalTo(cellAverageVoteLabel.snp.trailing).offset(25)
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(12)
        }
    }

    func makeCellToDetailButton() {
        cellToDetailButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
}