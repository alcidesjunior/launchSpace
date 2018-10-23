//
//  MissionStructAPI.swift
//  Space Launch
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import Foundation

struct MissionStruct: Codable {
    let flightNumber: Int?
    let missionName: String?
//    let missionID: [String?]
    let launchYear: String?
    let launchDateUnix: Int?
    let tentativeMaxPrecision: String?
    let rocket: Rocket?
    let launchSite: LaunchSite?
    let launchSuccess: Bool?
    let links: Links?
    let details: String?
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
//        case missionID = "mission_id"
        case launchYear = "launch_year"
        case launchDateUnix = "launch_date_unix"
        case tentativeMaxPrecision = "tentative_max_precision"
        case rocket
        case launchSite = "launch_site"
        case launchSuccess = "launch_success"
        case links, details
    }
}

struct LaunchSite: Codable {
    let siteID, siteName, siteNameLong: String?
    
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}

struct Links: Codable {
    let missionPatch, missionPatchSmall: String?
    let redditCampaign, redditLaunch, redditRecovery, redditMedia: String?
    let presskit: String?
    let articleLink, wikipedia, videoLink: String?
    let flickrImages: [String?]
    
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case flickrImages = "flickr_images"
    }
}

struct Rocket: Codable {
    let rocketID, rocketName, rocketType: String?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
    }
}

struct FirstStage: Codable {
    let cores: [Core?]
}

struct Core: Codable {
    let coreSerial: String?
    let reused: Bool?
    
    enum CodingKeys: String, CodingKey {
        case coreSerial = "core_serial"
        case reused = "reused"
    }
}

struct SecondStage: Codable {
    let block: Int?
    let payloads: [Payload?]
}

struct Payload: Codable {
    let payloadID: String?
    let reused: Bool?
    let customers: [String?]
    let nationality, manufacturer: String?
    let payloadType: String?
    
    enum CodingKeys: String, CodingKey {
        case payloadID = "payload_id"
        case payloadType = "payload_type"
        case reused, customers, nationality, manufacturer
    }
}


