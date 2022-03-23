
import UIKit


class SettingsCell: UITableViewCell {
    static let reusableCellIdentifier = "SettingsCellId"
    
    let titleBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(titleBackgroundView)
        addSubview(titleLabel)
     
        //need x,y,width,height anchors
        titleBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
        titleBackgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        titleBackgroundView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //need x,y,width,height anchors
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
