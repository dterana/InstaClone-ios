# InstaClone-ios

A bare-bones clone of Instagram:

* Parse mobile backend as a service
* Authenticated login
* Subscribe to feeds, upload pictures, view your feeds

Requires the use of your own Parse ApplicationId / Client Key

In a Config.swift file, put your credentials as following:

```swift
import Foundation

let APPLICATION_ID = "123XXX"
let CLIENT_KEY = "123XXX"
let SERVER_URI = "http://ec2-XXX-XXX-XXX-XXX.us-east-2.compute.amazonaws.com:80/parse"
```
