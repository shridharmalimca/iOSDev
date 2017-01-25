# Acknowledgements
This application makes use of the following third party libraries:

## KSReachability

KSReachability
==============

By Karl Stenerud

### A better reachability for a modern age.


Introduction
------------

A long time ago in an Xcode far away, Apple provided "Reachability", an example Objective-C wrapper to demonstrate the SystemConfiguration Reachability APIs. On the whole it works well enough, but it could be so much more!

KSReachability takes reachability to the next level.


Features
--------

- Reachability to the network in general, to a host, or to an IPV4 or IPV6 address.
- Notifications/callbacks via NSNotification, blocks, and KVO.
- Fetching status values doesn't block.
- Callbacks and KVO always occur on the main thread, so it's UI-safe.
- KSReachableOperation: A one-shot operation to perform when reachability is established.
- Supports iOS and Mac OS X.
- Can be built with or without ARC, in CLANG or GCC.

Usage
-----

#### Import:
    #import "KSReachability.h"

#### Create a KSReachability object:
    self.reachability = [KSReachability reachabilityToHost:hostname];

#### Use blocks:
    self.reachability.onReachabilityChanged = ^(KSReachability* reachability)
    {
        NSLog(@"Reachability changed to %d (blocks)", reachability.reachable);
    };

#### Or use NSNotifications:
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onReachabilityChanged:)
                                                 name:kDefaultNetworkReachabilityChangedNotification
                                               object:nil];
    ...

    self.reachability.notificationName = kDefaultNetworkReachabilityChangedNotification;
    ...

    - (void) onReachabilityChanged:(NSNotification*) notification
    {
        KSReachability* reachability = (KSReachability*)notification.object;
        NSLog(@"Reachability changed to %d (NSNotification)", reachability.reachable);
    }

#### Or use KVO:
    [self.reachability addObserver:self
                        forKeyPath:@"reachable"
                           options:NSKeyValueObservingOptionNew
                           context:NULL];
    ...

    - (void)observeValueForKeyPath:(NSString *)keyPath
                          ofObject:(id)object
                            change:(NSDictionary *)change
                           context:(void *)context
    {
        KSReachability* reachability = (KSReachability*)object;
        NSLog(@"Reachability changed to %d (KVO)", reachability.reachable);
    }

#### Add a reachable operation:
    // Create a one-shot operation that gets fired once the host is reachable.
    self.reachableOperation = [KSReachableOperation operationWithHost:hostname
                                                            allowWWAN:NO
                                               onReachabilityAchieved:^
                               {
                                   [self showAlertWithTitle:@"One-time message"
                                                    message:@"Host is reachable!"];
                               }];

Caveats
-------

### The Meaning of Reachability

As per [Apple's SCNetworkReachability documentation](https://developer.apple.com/LIBRARY/IOS/documentation/SystemConfiguration/Reference/SCNetworkReachabilityRef/Reference/reference.html), a remote host is considered reachable when a data packet addressed to that host **can leave the local device** (i.e. the host is **theoretically** reachable). It does **NOT** guarantee that data will actually be received by the host or that the host will respond to a connection request! For example, if the host has a DNS record, but the host itself is down, it will **still** be considered **reachable**.

### Delays Due to DNS Lookups

KSReachability must do a DNS lookup to determine reachability to a host by name. Since this lookup can take upwards of 10 seconds in extreme cases, it is performed in the background. As a consequence, a newly created KSReachability object will always have its state set to unreachable until this lookup completes. If you need the true reachability to a host, you must wait for the "initialized" property to change to YES (it supports KVO). As an alternative, you can set the callback "onInitializationComplete".


Full Example
------------

I've included a full example project in this repository.

In **iOSReachability**, see **ViewController.h** and **ViewController.m** for details.

In **MacReachability**, see **AppDelegate.h** and **AppDelegate.m** for details.


License
-------

Copyright (c) 2012 Karl Stenerud. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall remain in place
in this source code.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


## MBProgressHUD

Copyright © 2009-2016 Matej Bukovinski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## MSGraphSDK

Microsoft Graph iOS SDK

Copyright 2015 Microsoft Corporation

All right reserved.

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.



## MSGraphSDK-NXOAuth2Adapter

Microsoft Graph iOS SDK Authentication Quick-Start Kit

Copyright 2015 Microsoft Corporation

All right reserved.

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.



## NXOAuth2Client

Copyright © 2012-2014, nxtbgthng GmbH

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of nxtbgthng nor the
  names of its contributors may be used to endorse or promote products
  derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


## SRKUtility

The MIT License (MIT)

Copyright (c) 2015 Sagar R. Kothari

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


Generated by CocoaPods - https://cocoapods.org
