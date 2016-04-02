/*
 * Copyright 2010-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */


/**
 * This is the the DNS domain name of the endpoint your Token Vending
 * Machine is running.  (For example, if your TVM is running at
 * http://mytvm.elasticbeanstalk.com this parameter should be set to
 * mytvm.elasticbeanstalk.com.)
 */
#define TOKEN_VENDING_MACHINE_URL    @"jwrf58qefzm.elasticbeanstalk.com"

#define TOKEN_VENDING_MACHINE_REGISTER_URL    @"https://jwrf58qefzm.elasticbeanstalk.com/registeruser"

#define USER_REGISTER_DOMAIN        @"tvlakulam"

#define SHARE_DOMAIN @"sh49ubwrlaspree"

#define SHARE_KEY_DOMAIN @"bp59zebks"

#define REGISTER_SUCCESS_STRING @"<title>jwrf58qefzm - Success</title>"

#define REGISTER_ERROR_STRING @"<title>jwrf58qefzm - Error</title>"

/**
 * This is the App Name you may have provided in the AWS Elastic Beanstalk
 * configuration.  It was the value provided for PARAM2.  If no value was
 * provided it should be defaulted to "MyMobileAppName".
 */
#define APP_NAME                     @"jwrf58qefzm"

/**
 * This indiciates whether or not the TVM is supports SSL connections.
 */
#define USE_SSL                      YES


#define CREDENTIALS_ALERT_MESSAGE    @"Please update the Constants.h file with your credentials or Token Vending Machine URL."
#define ACCESS_KEY_ID                @"USED-ONLY-FOR-TESTING"  // Leave this value as is.
#define SECRET_KEY                   @"USED-ONLY-FOR-TESTING"  // Leave this value as is.





