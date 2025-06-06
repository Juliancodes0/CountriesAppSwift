//
//  CustomTableViewCell.swift
//  CountriesAPIUIKit
//
//  Created by Julian Burton on 6/6/25
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"

    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 4
        view.backgroundColor = .systemBackground
        return view
    }()

    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()

    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        return label
    }()

    private let regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .tertiaryLabel
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)

        [countryNameLabel, capitalLabel, regionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview($0)
        }

        cardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            countryNameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            countryNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            countryNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),

            capitalLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 6),
            capitalLabel.leadingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor),
            capitalLabel.trailingAnchor.constraint(equalTo: countryNameLabel.trailingAnchor),

            regionLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 6),
            regionLabel.leadingAnchor.constraint(equalTo: capitalLabel.leadingAnchor),
            regionLabel.trailingAnchor.constraint(equalTo: capitalLabel.trailingAnchor),
            regionLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12)
        ])
    }

    public func setProperties(countryText: String, capital: String, region: String) {
        countryNameLabel.text = countryText
        capitalLabel.text = "Capital: \(capital)"
        regionLabel.text = "Region: \(region)"
    }
}
