
import UIKit
import SafariServices
import Foundation



public final class SettingsView: UIViewController {
    private var settingsSections: [SettingsSection]
    
    private struct Constants {
        static let cellHeight: CGFloat = 81
        static let headerHeight: CGFloat = 81
        static let estimatedRowHeight: CGFloat = 60
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reusableCellIdentifier)
        return tableView
    }()
    
    
    
    
    
    
    init(settingsSections: [SettingsSection]) {
        self.settingsSections = settingsSections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        
        view.addSubview(tableView)
//        self.navigationController?.isNavigationBarHidden = false
        applyConstraints()
        reloadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
    }
    
    func reloadData() {
        settingsSections = settingsSections.map { sectionConstant in
            var section = sectionConstant
            section.items = sectionConstant.items.filter {
                $0.isShown > 0
            }
            return section
        }.filter {
            $0.items.isEmpty == false
        }
        tableView.reloadData()
    }
    
    func shareApp() {
        let urlString = "appUrl"
        let text = "messageToShare" + urlString
        
        let alert = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        // if we're on iPad there is nowhere sensible to anchor this from, so just center it
        if let popOver = alert.popoverPresentationController {
            popOver.sourceView = self.navigationController!.view
            popOver.sourceRect = CGRect(x: self.navigationController!.view.frame.midX, y: self.navigationController!.view.frame.midY, width: 0, height: 0)
        }
        
        self.navigationController!.present(alert, animated: true)
    }
    
    func supportUs(_ associatedBonusItemId: String? = nil) {
//        let bonusConfig = PurchaseConfigurable(
//            configID: "bonus",
//            title: "",
//            statementImage: UIImage(named: "new_icon_3"),
//            statementLabelText: "DonateToSupportUs",
//            purchaseButtonTitle: "Donate",
//            successImage: UIImage(named: "heart_red"),
//            successLabelText: "Thanks",
//            successButtonTitle: "YouGotIt",
//            purchaseFailedText: "PurchaseFailed",
//            tryAgainButtonTitle: "TryAgain",
//            successAction: {
//
//                self.navigationController?.isNavigationBarHidden = true
//                self.openBonusDua()
//            },
//            purchaseIdForHistory: Constant.purchaseLogId
//        )
//
//        let purchasePresenter = PurchasePresenter(analytics: Analytics.shared,
//                                                  purchaseProductIdentifiers: [
//                                                    "com.joode.myPrice099",
//                                                    "com.joode.myPrice299",
//                                                    "com.joode.myPrice999"
//                                                  ],
//                                                  config: bonusConfig
//        )
//
//        let purchaseController = PurchaseController(presenter: purchasePresenter)
//        self.navigationController?.pushViewController(purchaseController, animated: true)
//        self.navigationController?.isNavigationBarHidden = false
    }
    
    func openWebPage(_ settingsItem: SettingsItem){
        guard let urlString = settingsItem.url, let url = URL(string: urlString) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    func openArticle(_ settingsItem: SettingsItem) {
        guard let urlString = settingsItem.url, let _ = URL(string: urlString) else { return }
        
        let webVC = WebController()
        webVC.urlString = urlString
        webVC.title = settingsItem.title
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func openNotificationPanel() {
//        let locale = String(Locale.current.identifier.prefix(2))
//
//        let controlPanel: [ControlPanelSection]?
//
//        if let panel = Storage.shared.controlPanelDict[locale] {
//            controlPanel = panel
//        } else {
//            controlPanel = Storage.shared.controlPanelDict["en"]
//        }
//
//        let notificationScheduler: LocalScheduler?
//
//        if let scheduler = Storage.shared.localNotificationDict[locale] {
//            notificationScheduler = scheduler
//        } else {
//            notificationScheduler = Storage.shared.localNotificationDict["en"]
//        }
//
//        let notificationModule = NotificationKit.NotificationModuleBuilder(
//            controlPanel: controlPanel,
//            notificationScheduler: notificationScheduler,
//            analytics: Analytics.shared
//        )
//
//        self.navigationController?.pushViewController(notificationModule.view, animated: true)
    }
    
    func requestReview(_ circumstance: String = "Launch") {
//        if #available(iOS 10.3, *) {
//
//            Analytics.shared.logEvent("Requesting review", properties: [
//                "circumstance": circumstance,
//                "App Open Count": AppHelper.shared.appOpenCount
//            ])
//
//            DispatchQueue.main.async {
//                SKStoreReviewController.requestReview()
//            }
//
//        } else {
//            // Fallback on earlier versions
//            // Try any other 3rd party or manual method here.
//        }
    }
    
}


extension SettingsView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = settingsSections[indexPath.section]
        let item = section.items[indexPath.row]
        
        switch (item.id, item.type) {
        case (_, "page"):
            openWebPage(item)
        case (_, "article"):
            openArticle(item)
        case ("share_app",_):
            shareApp()
        case ("support_app",_):
            supportUs()
        case ("rate_app",_):
            requestReview("Settings")
        case ("notification", _):
            openNotificationPanel()
        default:
            break
        }
    }
}


extension SettingsView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsSections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsSections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: Constants.headerHeight))
        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: view.bounds.width-20, height:  Constants.headerHeight))
        label.text = settingsSections[section].title
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.numberOfLines = 0
        headerView.addSubview(label)
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reusableCellIdentifier, for: indexPath) as! SettingsCell
        let section = settingsSections[indexPath.section]
        let item = section.items[indexPath.row]
        cell.titleLabel.text = item.title
        
        /// FIXME: add detail
//        cell.detailTextLabel?.text = item.detail
        
        return cell
    }
}
