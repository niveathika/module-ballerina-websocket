// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/log;
import ballerina/websocket;

@test:Config {}
function testText() returns websocket:Error? {
    websocket:Client wsClient = check new("ws://localhost:9090/chat/Alice");
    websocket:Error? result = wsClient->writeTextMessage("Hey");
    if (result is websocket:Error) {
        log:printError("Error occurred when writing text", 'error = result);
    }
    string serviceReply = check wsClient->readTextMessage();
    test:assertEquals(serviceReply, "Hi Alice! You have successfully connected to the chat");
    websocket:Error? err = wsClient->close(statusCode = 1000, timeout = 10);
}
