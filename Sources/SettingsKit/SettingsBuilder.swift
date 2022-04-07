
import Foundation



public final class SettingsBuilder {
    public let settingsView: SettingsView
    
    
    public init(analytics: SettingsAnalytics?){
        
        let sections: [SettingsSection] = StorageService().getControlPanel(from: "Settings")
        print(sections)
        
        self.settingsView = SettingsView(settingsSections: sections, analytics: analytics)
    }
}
