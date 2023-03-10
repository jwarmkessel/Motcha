//
//  AppConfiguration.swift
//  AmazonChimeSDKMessagingDemo
//
//  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//  SPDX-License-Identifier: MIT-0
//

import Foundation

private enum Constants { static let sandbox = "Sandbox" }

struct AwsConfig {
    // Geogrpahic region of services used in AWS.
    let region: String
    // Instance of Amazon Chime SDK messaging application.
    let appInstanceArn: String
    // API endpoint of lambda functions.
    let apiGatewayInvokeUrl: String
    // Service identifier of the Pinpoint resource.
    let pinpointAppArn: String
}

let SANDBOX_AWS_CONFIG = AwsConfig(
    region: "us-east-1",
    appInstanceArn: "arn:aws:chime:us-east-1:022636083072:app-instance/f029c133-f54a-4a7a-9a89-02462fd63c2b",
    apiGatewayInvokeUrl: "https://exiivcxeza.execute-api.us-east-1.amazonaws.com/prod/",
    pinpointAppArn: "PINPOINT_APPLICATION_ARN")

let PROD_CONFIG = AwsConfig(
    region: "us-east-1",
    appInstanceArn: "arn:aws:chime:us-east-1:431557582387:app-instance/46de27d0-d840-46da-823e-45ce37b7b18d",
    apiGatewayInvokeUrl: "https://jtuq1nnxm1.execute-api.us-east-1.amazonaws.com/prod/",
    pinpointAppArn: "PINPOINT_APPLICATION_ARN")

let config = Bundle.main.object(forInfoDictionaryKey: "Build Scheme Config") as! String
let AppConfiguration = config == Constants.sandbox ? SANDBOX_AWS_CONFIG : PROD_CONFIG
