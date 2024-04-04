//
//  HelloResponseModel.swift
//  VotioTest
//
//  Created by Andrei Harnashevich on 4.04.24.
//

// MARK: - HelloResponseModel
struct HelloResponseModel: Codable {
    let success: Int
    let result: String
    let config: Config
    let notification: Notification
}

// MARK: - Config
struct Config: Codable {
    let androidLastVer, androidMinVer: String
    let androidUpdateLink: String
    let iosLastVer, iosMinVer: String
    let iosUpdateLink: String
    let appAvailable: Bool
    let appUnavailableMessage: String
    let webviewCSS, webviewDarkCSS: String

    enum CodingKeys: String, CodingKey {
        case androidLastVer = "android_last_ver"
        case androidMinVer = "android_min_ver"
        case androidUpdateLink = "android_update_link"
        case iosLastVer = "ios_last_ver"
        case iosMinVer = "ios_min_ver"
        case iosUpdateLink = "ios_update_link"
        case appAvailable = "app_available"
        case appUnavailableMessage = "app_unavailable_message"
        case webviewCSS = "webview_css"
        case webviewDarkCSS = "webview_dark_css"
    }
}

// MARK: - Notification
struct Notification: Codable {
    let showNotification: Bool
    let title, text: String

    enum CodingKeys: String, CodingKey {
        case showNotification = "show_notification"
        case title, text
    }
}
