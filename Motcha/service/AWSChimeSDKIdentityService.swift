//
//  AWSChimeSDKIdentityService.swift
//  AmazonChimeSDKMessagingDemo
//
//  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
//  SPDX-License-Identifier: MIT-0
//

import AWSChimeSDKIdentity
import AWSCognitoIdentityProvider

class AWSChimeSDKIdentityService {

    private enum Constants {
        static let userPool = "us-east-1_Tv39HaVYF"
        static let identityPool = "us-east-1:9c0d0e1c-387c-48ef-9c46-fe2e69eda419"
    }
    
    static let shared = AWSChimeSDKIdentityService()
    private var awsChimeSDKIdentityClient: AWSChimeSDKIdentity?
    private let TAG = "AWSChimeSDKIdentityService"
    
    private init() {
        guard let credentials = AuthService.currentUserCredentials else {
            print("\(TAG) init() current user credential is nil")
            return
        }
        let credentialsProvider = AWSBasicSessionCredentialsProvider(accessKey: credentials.accessKeyId,
                                                                     secretKey: credentials.secretAccessKey,
                                                                     sessionToken: credentials.sessionToken)
        if let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider) {
            AWSChimeSDKIdentity.register(with: configuration, forKey: K.awsChimeSDKIdentityClientKey)
            awsChimeSDKIdentityClient = AWSChimeSDKIdentity(forKey: K.awsChimeSDKIdentityClientKey)
        } else {
            print("\(TAG) init() configuration is nil")
        }
    }
    
    func registerAppInstanceUserEndpoint(deviceToken: String,
                                         appInstanceUserArn: String,
                                         completion: @escaping (AWSChimeSDKIdentityRegisterAppInstanceUserEndpointResponse?, Error?) -> Void) {
        let request: AWSChimeSDKIdentityRegisterAppInstanceUserEndpointRequest = AWSChimeSDKIdentityRegisterAppInstanceUserEndpointRequest()
        let endpointAttributes: AWSChimeSDKIdentityEndpointAttributes = AWSChimeSDKIdentityEndpointAttributes()
        endpointAttributes.deviceToken = deviceToken
        request.clientRequestToken = UUID().uuidString
        request.appInstanceUserArn = appInstanceUserArn
        request.types = .apnsSandbox
        request.resourceArn = AppConfiguration.pinpointAppArn
        request.endpointAttributes = endpointAttributes
        
        awsChimeSDKIdentityClient?.registerAppInstanceUserEndpoint(request) { response, error in
            completion(response, error)
        }
    }
    
    func describeAppInstanceUserEndpoint(endpointId: String?,
                                         appInstanceUserArn: String?,
                                         completion: @escaping (AWSChimeSDKIdentityDescribeAppInstanceUserEndpointResponse?, Error?) -> Void) {
        let request: AWSChimeSDKIdentityDescribeAppInstanceUserEndpointRequest = AWSChimeSDKIdentityDescribeAppInstanceUserEndpointRequest()
        request.appInstanceUserArn = appInstanceUserArn
        request.endpointId = endpointId
        
        awsChimeSDKIdentityClient?.describeAppInstanceUserEndpoint(request) { response, error in
            completion(response, error)
        }
    }
    
    func updateAppInstanceUserEndpoint(name: String?,
                                       allowMessage: AWSChimeSDKIdentityAllowMessages,
                                       endpointId: String?,
                                       appInstanceUserArn: String?,
                                       completion: @escaping (AWSChimeSDKIdentityUpdateAppInstanceUserEndpointResponse?, Error?) -> Void) {
        let request: AWSChimeSDKIdentityUpdateAppInstanceUserEndpointRequest = AWSChimeSDKIdentityUpdateAppInstanceUserEndpointRequest()
        request.appInstanceUserArn = appInstanceUserArn
        request.endpointId = endpointId
        request.allowMessages = allowMessage
        request.name = name
        
        awsChimeSDKIdentityClient?.updateAppInstanceUserEndpoint(request) { response, error in
            completion(response, error)
        }
    }
    
    func deregisterAppInstanceUserEndpoint(endpointId: String?,
                                           appInstanceUserArn: String?,
                                           completion: @escaping (Error?) -> Void) {
        let request: AWSChimeSDKIdentityDeregisterAppInstanceUserEndpointRequest = AWSChimeSDKIdentityDeregisterAppInstanceUserEndpointRequest()
        request.appInstanceUserArn = appInstanceUserArn
        request.endpointId = endpointId
        
        awsChimeSDKIdentityClient?.deregisterAppInstanceUserEndpoint(request) { error in
            completion(error)
        }
    }
    
    func listAllUsers(completion: @escaping (AWSCognitoIdentityProviderListUsersResponse?, Error?) -> Void) {
        //https://stackoverflow.com/questions/42351925/awss3-region-plist-configuration-issue-the-service-configuration-is-nil
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1,identityPoolId: Constants.identityPool)
        let configuration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)

        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let provider = AWSCognitoIdentityProvider.default()
        guard let request = AWSCognitoIdentityProviderListUsersRequest() else {
            return
        }
        
        request.userPoolId = Constants.userPool

        provider.listUsers(request) { response, error in
            completion(response, error)
        }
    }
}
