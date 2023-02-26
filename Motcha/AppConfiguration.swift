//
//  AppConfiguration.swift
//  AmazonChimeSDKMessagingDemo
//
//  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//  SPDX-License-Identifier: MIT-0
//

import Foundation

struct AwsConfig {
    let region: String
    let appInstanceArn: String
    let apiGatewayInvokeUrl: String
    let pinpointAppArn: String
}

let DEV_CONFIG = AwsConfig(
    region: "us-east-1",
    appInstanceArn: "arn:aws:chime:us-east-1:022636083072:app-instance/f029c133-f54a-4a7a-9a89-02462fd63c2b",
    apiGatewayInvokeUrl: "https://exiivcxeza.execute-api.us-east-1.amazonaws.com/prod/",
    pinpointAppArn: "PINPOINT_APPLICATION_ARN")

let PROD_CONFIG = AwsConfig(
    region: "us-east-1",
    appInstanceArn: "arn:aws:chime:us-east-1:431557582387:app-instance/17145b22-ded4-4762-8e64-344d26c323aa",
    apiGatewayInvokeUrl: "https://3qe9qan1ai.execute-api.us-east-1.amazonaws.com/prod/",
    pinpointAppArn: "PINPOINT_APPLICATION_ARN")

let config = Bundle.main.object(forInfoDictionaryKey: "Config") as! String
let AppConfiguration = config == "Staging" ? DEV_CONFIG : PROD_CONFIG
