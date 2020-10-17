//
//  ViewController.swift
//  lofiii
//
//  Created by Kevin Laminto on 17/10/20.
//

import Cocoa
import SnapKit
import WebKit

class ViewController: NSViewController {
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraint()
        setupVideo()
        
        createHelpMenus()
    }
    
    private func setupView() {
        view.addSubview(webView)
    }
    
    private func setupConstraint() {
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    /// Load WKWebview with youtube embed
    private func setupVideo() {
        let url = URL(string: "https://www.youtube.com/embed/5qap5aO4i9A?autoplay=1")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    /// Create help menus for users to access various contact options
    private func createHelpMenus() {
        let links = ["Email", "Twitter", "Website"]
        var tagNumber = 0
        for link in links {
            let menuItem = NSMenuItem(title: link, action: #selector(helpMenuTapped), keyEquivalent: String(link.prefix(1)))
            menuItem.tag = tagNumber
            NSApplication.shared.helpMenu?.addItem(menuItem)
            
            tagNumber += 1
        }
    }
    
    /// Help menu event handlers
    @objc private func helpMenuTapped(_ sender: NSMenuItem) {
        switch sender.tag {
        case 0:
            let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
            service.recipients = ["kevinlaminto.dev@gmail.com"]
            service.subject = "[lofiii] Hi there! ✉️"

            service.perform(withItems: [])
        case 1:
            let url = URL(string:"https://twitter.com/kevinlx_")!
            NSWorkspace.shared.open([url],
                                    withAppBundleIdentifier:"com.apple.Safari",
                                    options: [],
                                    additionalEventParamDescriptor: nil,
                                    launchIdentifiers: nil)
        case 2:
            let url = URL(string:"https://kevinweb.tech")!
            NSWorkspace.shared.open([url],
                                    withAppBundleIdentifier:"com.apple.Safari",
                                    options: [],
                                    additionalEventParamDescriptor: nil,
                                    launchIdentifiers: nil)
        default: break
        }
    }
}
