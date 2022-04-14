
import Foundation
import NotificationKit



public final class SettingsBuilder {
    public let settingsView: SettingsView
    
    
    public init(analytics: SettingsAnalytics?, controlPanel: [ControlPanelSection]?, localSchedule: LocalScheduler?){
        
        let sections: [SettingsSection] = StorageService().getControlPanel(from: "Settings")
        print(sections)
        
//        self.settingsView = SettingsView(settingsSections: sections, analytics: analytics)
        self.settingsView = SettingsView(settingsSections: sections, analytics: analytics, controlPanel: controlPanel, localSchedule: localSchedule)
    }
}
