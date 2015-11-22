//
//
// My libarary for all project

#import "Utils.h"

@implementation Utils
+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg{
    return  [Utils showAlertWithTitle:title andMsg:msg delegate:nil];
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg delegate:(id)delegate{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    return alertView;
}

+ (void)makeAllTextFieldsPaddingInContainerView:(UIView *)parentView{
    for (UIView *subView in parentView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)subView;
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, textField.frame.size.height)];
            textField.leftViewMode = UITextFieldViewModeAlways;
        }else if([subView subviews].count > 0){
            [self makeAllTextFieldsPaddingInContainerView:subView];
        }
    }
}

+ (NSString *)uuidString
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+ (void)registerPushNotification{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

+ (NSString *)deviceTokenStringFromData:(NSData *)tokenData{
    NSString* deviceTokenString = [[[[tokenData description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    return deviceTokenString;
}

+ (BOOL)textIsNumber:(NSString *)str{
    NSCharacterSet *_numericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:str];
    
    if ([_numericOnly isSupersetOfSet: myStringSet]) {
        return YES;
    }
    return NO;
}

+ (BOOL)networkConnected{
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (status == NotReachable) {
        return NO;
    }
    return YES;
}

+ (id)loadJsonFromFile:(NSString *)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return json;
}

+ (void)callWithNumber:(NSString *)phoneNo{
    NSString *phoneScheme = [@"tel://" stringByAppendingString:phoneNo];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneScheme]];
}

+ (void)gotoWebsiteWithUrl:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)networkConnectedByWifi{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status != NotReachable){
        if (status == ReachableViaWiFi)
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)networkConnectedBy3G{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status != NotReachable){
        if (status == ReachableViaWWAN)
        {
            return YES;
        }
    }
    return NO;
}

+ (CGSize)sizeOfText:(NSString *)text width:(NSInteger ) width font:(UIFont *)font{
    //Label text
    NSString *aLabelTextString = text;
    
    //Label font
    UIFont *aLabelFont = font;
    
    //Width of the Label
    CGFloat aLabelSizeWidth = width;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        //version < 7.0
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSFontAttributeName : aLabelFont
                                                        }
                                              context:nil].size;
    }else{
        //version >= 7.0
        //Return the calculated size of the Label
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSFontAttributeName : aLabelFont
                                                        }
                                              context:nil].size;
    }
}

+ (NSString *)getStringIgnoreNull:(id)str{
    if (str == [NSNull null]) {
        return nil;
    }
    return str;
}

+ (id)getObjectIgnoreNull:(id)obj{
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}
+ (NSString *)readStringFromHtmlFile:(NSString *)filename extension:(NSString *)ext{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    return [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
}

@end

