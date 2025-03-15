import UIKit

class CountryCellTableViewCell: UITableViewCell {
    
    private enum LabelType {
        case name
        case code
        case capital
    }

    private let nameLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabel(.name, label: nameLabel)
        setupLabel(.code, label: codeLabel)
        setupLabel(.capital, label: capitalLabel)
        
        // Create a horizontal stack for name and code
        let nameCodeStackView = UIStackView(arrangedSubviews: [nameLabel, codeLabel])
        nameCodeStackView.axis = .horizontal
        nameCodeStackView.spacing = 8
        nameCodeStackView.alignment = .leading
        nameCodeStackView.distribution = .equalSpacing
        
        // Create a vertical stack for nameCodeStackView and capitalLabel
        let mainStackView = UIStackView(arrangedSubviews: [nameCodeStackView, capitalLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Move codeLabel to the right
        codeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with country: Country) {
        nameLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
    
    private func setupLabel(_ labelType: LabelType, label: UILabel) {
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        switch labelType {
        case .name:
            label.font = UIFont.preferredFont(forTextStyle: .body)
        case .code:
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
        case .capital:
            label.font = UIFont.preferredFont(forTextStyle: .caption2)
            label.textColor = .gray
        }
    }
}
