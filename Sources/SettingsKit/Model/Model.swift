
import Foundation


public struct SettingsSection: Decodable {
    let id: String
    let titleEn: String
    let titleFr: String
    let titleId: String
    let titleRu: String
    let titleTr: String
    
    var items: [SettingsItem]
    
    var title: String {
        let locale = Locale.current.identifier
        
        if locale.hasPrefix("tr") {
            return titleTr
        } else if locale.hasPrefix("ru") {
            return titleRu
        } else if locale.hasPrefix("fr") {
            return titleFr
        } else if locale.hasPrefix("id") {
            return titleId
        } else {
            return titleEn
        }
    }
    
}

public struct SettingsItem: Decodable {
    let id: String
    let type: String

    let titleEn: String
    let titleFr: String
    let titleId: String
    let titleRu: String
    let titleTr: String
    
    let detailEn: String
    let detailFr: String
    let detailId: String
    let detailRu: String
    let detailTr: String
    
    let urlEn: String?
    let urlFr: String?
    let urlId: String?
    let urlRu: String?
    let urlTr: String?
    
    let showEn: Int
    let showFr: Int
    let showId: Int
    let showRu: Int
    let showTr: Int
    
    var title: String {
        let locale = Locale.current.identifier
        
        if locale.hasPrefix("tr") {
            return titleTr
        } else if locale.hasPrefix("ru") {
            return titleRu
        } else if locale.hasPrefix("fr") {
            return titleFr
        } else if locale.hasPrefix("id") {
            return titleId
        } else {
            return titleEn
        }
    }
    
    var detail: String {
        let locale = Locale.current.identifier
        
        if locale.hasPrefix("tr") {
            return detailTr
        } else if locale.hasPrefix("ru") {
            return detailRu
        } else if locale.hasPrefix("fr") {
            return detailFr
        } else if locale.hasPrefix("id") {
            return detailId
        } else {
            return detailEn
        }
    }
    
    var url: String? {
        let locale = Locale.current.identifier
        
        if locale.hasPrefix("tr") {
            return urlTr
        } else if locale.hasPrefix("ru") {
            return urlRu
        } else if locale.hasPrefix("fr") {
            return urlFr
        } else if locale.hasPrefix("id") {
            return urlId
        } else {
            return urlEn
        }
    }
    
    var isShown: Int {
        let locale = Locale.current.identifier
        
        if locale.hasPrefix("tr") {
            return showTr
        } else if locale.hasPrefix("ru") {
            return showRu
        } else if locale.hasPrefix("fr") {
            return showFr
        } else if locale.hasPrefix("id") {
            return showId
        } else {
            return showEn
        }
    }
}
