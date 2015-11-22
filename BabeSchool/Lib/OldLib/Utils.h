//
//
// My libarary for all project


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MBProgressHUD.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface Utils : NSObject
+ (NSString *)uuidString;
+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;
+ (UIAlertView *)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg delegate:(id)delegate;
+ (void)registerPushNotification;
+ (NSString *)deviceTokenStringFromData:(NSData *)tokenData;
+ (BOOL)textIsNumber:(NSString *)str;

+ (BOOL) networkConnected;
+ (id) loadJsonFromFile:(NSString *)fileName;
+ (void) callWithNumber:(NSString *)phoneNo;
+ (void) gotoWebsiteWithUrl:(NSString *)url;
+ (BOOL) networkConnectedByWifi;
+ (BOOL)networkConnectedBy3G;
+ (CGSize)sizeOfText:(NSString *)text width:(NSInteger ) width font:(UIFont *)font;
+ (NSString *)getStringIgnoreNull:(id) str;
+ (id)getObjectIgnoreNull:(id)obj;
+ (NSString *)readStringFromHtmlFile:(NSString *)filename extension:(NSString *)ext;
+ (void)makeAllTextFieldsPaddingInContainerView:(UIView *)parentView;
@end
