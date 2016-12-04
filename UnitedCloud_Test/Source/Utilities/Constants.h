//
//  Channel.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//


#ifndef Constants_h
#define Constants_h

#define kAnimationDuration 0.3f
// Notifications

static NSString *const OPEN_MENU_NOTIFICATION = @"OPEN_MENU_NOTIFICATION";
static NSString *const CLOSE_MENU_NOTIFICATION = @"CLOSE_MENU_NOTIFICATION";
static NSString *const OPEN_CHANNEL_NOTIFICATION = @"OPEN_CHANNEL_NOTIFICATION";

//URLs
static NSString *const JSON_URL = @"http://sergej.si/konkurs/list.json";
static NSString *const LOGO_IMAGE_URL = @"http://info.nettvplus.com/static/resources/nettvplus/images/channels/app/overlay/";
static NSString *const STREAM_URL_BASE = @"http://best.str.nettvplus.com:8080/stream?sp=partners&u=konkurs&p=k0nk00rs&player=m3u8";
#define kMenuOffset 200.0f


#endif /* Constants_h */
