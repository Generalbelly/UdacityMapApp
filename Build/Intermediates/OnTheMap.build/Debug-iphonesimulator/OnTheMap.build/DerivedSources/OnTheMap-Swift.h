// Generated by Apple Swift version 1.2 (swiftlang-602.0.53.1 clang-602.0.53)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
#if __has_feature(nullability)
#  define SWIFT_NULLABILITY(X) X
#else
# if !defined(__nonnull)
#  define __nonnull
# endif
# if !defined(__nullable)
#  define __nullable
# endif
# if !defined(__null_unspecified)
#  define __null_unspecified
# endif
#  define SWIFT_NULLABILITY(X)
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import MapKit;
@import ObjectiveC;
@import CoreLocation;
@import WebKit;
#endif

#import "/Users/shimmennobuyoshi/Desktop/OnTheMap/OnTheMap/OnTheMap-Bridging-Header.h"

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;
@class NSURL;

SWIFT_CLASS("_TtC8OnTheMap11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (BOOL)application:(UIApplication * __nonnull)application openURL:(NSURL * __nonnull)url sourceApplication:(NSString * __nullable)sourceApplication annotation:(id __nullable)annotation;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UdacityStudent;
@class UITableView;
@class NSIndexPath;
@class UITableViewCell;
@class UIStoryboardSegue;
@class UIActivityIndicatorView;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC8OnTheMap18ListViewController")
@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * __null_unspecified activityIndicator;
@property (nonatomic, weak) IBOutlet UITableView * __null_unspecified tableView;
@property (nonatomic, copy) NSArray * __nonnull udacityStudents;
@property (nonatomic, copy) NSString * __nullable urlString;
- (void)logoutTapped:(id __nonnull)sender;
- (void)refreshTapped:(id __nonnull)sender;
- (void)addTapped:(id __nonnull)sender;
- (void)viewDidLoad;
- (void)addButtonsToNavbar;
- (void)fetchStudentinfo;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)tableView:(UITableView * __nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (void)statusCodeChecker:(NSInteger)statusCode;
- (void)displayAlertView:(NSString * __nonnull)message;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIView;
@class FBSDKLoginButton;
@class FBSDKLoginManagerLoginResult;
@class NSError;
@class UITextField;
@class NSNotification;

SWIFT_CLASS("_TtC8OnTheMap19LoginViewController")
@interface LoginViewController : UIViewController <UITextFieldDelegate, FBSDKLoginButtonDelegate>
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified emailField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified passwordField;
@property (nonatomic, weak) IBOutlet FBSDKLoginButton * __null_unspecified fbLoginButton;
@property (nonatomic) IBOutlet UIActivityIndicatorView * __null_unspecified activityIndicator;
@property (nonatomic) UIView * __nullable translucentView;
@property (nonatomic, readonly, copy) NSArray * __nonnull permissions;
- (IBAction)loginButtonTapped:(id __nonnull)sender;
- (void)statusCodeChecker:(NSInteger)statusCode;
- (void)displayAlertView:(NSString * __nonnull)message;
- (void)normalLogin;
- (void)fbLogin;
- (void)loginCompleted;
- (void)removeAivandTv;
- (IBAction)signUpTapped:(id __nonnull)sender;
- (void)viewDidLoad;
- (void)loginButton:(FBSDKLoginButton * __null_unspecified)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult * __null_unspecified)result error:(NSError * __null_unspecified)error;
- (void)loginButtonDidLogOut:(FBSDKLoginButton * __null_unspecified)loginButton;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (void)subscribeToKeyboardNotification;
- (void)unsubscribeToKeyboardNotification;
- (void)keyboardWillShow:(NSNotification * __nonnull)notification;
- (void)keyboardWillHide:(NSNotification * __nonnull)notification;
- (CGFloat)getKeyboardHeight:(NSNotification * __nonnull)notification;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class MKMapView;
@protocol MKAnnotation;
@class MKAnnotationView;
@class UIControl;

SWIFT_CLASS("_TtC8OnTheMap17MapViewController")
@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, copy) NSArray * __nonnull udacityStudents;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * __null_unspecified activityIndicator;
- (void)logoutTapped:(id __nonnull)sender;
- (void)refreshTapped:(id __nonnull)sender;
- (void)addTapped:(id __nonnull)sender;
@property (nonatomic, weak) IBOutlet MKMapView * __null_unspecified mapView;
- (void)viewDidLoad;
- (void)addButtonsToNavbar;
- (void)addAnnotations;
- (void)fetchStudentLocation;
- (MKAnnotationView * __null_unspecified)mapView:(MKMapView * __null_unspecified)mapView viewForAnnotation:(id <MKAnnotation> __null_unspecified)annotation;
- (void)mapView:(MKMapView * __null_unspecified)mapView annotationView:(MKAnnotationView * __null_unspecified)view calloutAccessoryControlTapped:(UIControl * __null_unspecified)control;
- (void)statusCodeChecker:(NSInteger)statusCode;
- (void)displayAlertView:(NSString * __nonnull)message;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSURLSession;

SWIFT_CLASS("_TtC8OnTheMap11ParseClient")
@interface ParseClient : NSObject
+ (ParseClient * __nonnull)sharedInstance;
@property (nonatomic) NSURLSession * __nonnull session;
@property (nonatomic, copy) NSString * __nullable objectId;
@property (nonatomic, copy) NSArray * __nullable studentInfo;
@property (nonatomic, copy) NSString * __nullable uniqueKey;
@property (nonatomic, copy) NSString * __nullable firstName;
@property (nonatomic, copy) NSString * __nullable lastName;
@property (nonatomic, copy) NSString * __nullable mapString;
@property (nonatomic, copy) NSString * __nullable mediaURL;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface ParseClient (SWIFT_EXTENSION(OnTheMap))
@end

@class MKPlacemark;
@class UIButton;

SWIFT_CLASS("_TtC8OnTheMap21PostingViewController")
@interface PostingViewController : UIViewController <UITextFieldDelegate, MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView * __null_unspecified activityIndicator;
@property (nonatomic) MKPlacemark * __nullable location;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified submitButton;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified findButton;
- (IBAction)submitTapped:(id __nonnull)sender;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified linkTextField;
@property (nonatomic, weak) IBOutlet MKMapView * __null_unspecified mapView;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified mapTextField;
- (IBAction)buttonTapped:(id __nonnull)sender;
- (void)searchGeocodeForLocation;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)statusCodeChecker:(NSInteger)statusCode;
- (void)displayAlertView:(NSString * __nonnull)message;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (void)subscribeToKeyboardNotification;
- (void)unsubscribeToKeyboardNotification;
- (void)keyboardWillShow:(NSNotification * __nonnull)notification;
- (void)keyboardWillHide:(NSNotification * __nonnull)notification;
- (CGFloat)getKeyboardHeight:(NSNotification * __nonnull)notification;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIColor (SWIFT_EXTENSION(OnTheMap))
+ (UIColor * __nonnull)rgb:(NSInteger)r g:(NSInteger)g b:(NSInteger)b alpha:(CGFloat)alpha;
@end


SWIFT_CLASS("_TtC8OnTheMap13UdacityClient")
@interface UdacityClient : NSObject
+ (UdacityClient * __nonnull)sharedInstance;
@property (nonatomic) NSURLSession * __nonnull session;
@property (nonatomic, copy) NSString * __nullable email;
@property (nonatomic, copy) NSString * __nullable password;
@property (nonatomic, copy) NSString * __nullable fbToken;
@property (nonatomic, copy) NSString * __nullable userId;
@property (nonatomic, copy) NSString * __nullable sessionId;
@property (nonatomic, copy) NSString * __nullable firstName;
@property (nonatomic, copy) NSString * __nullable lastName;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface UdacityClient (SWIFT_EXTENSION(OnTheMap))
@end


SWIFT_CLASS("_TtC8OnTheMap14UdacityStudent")
@interface UdacityStudent : NSObject
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly, copy) NSString * __nonnull name;
@property (nonatomic, copy) NSString * __nonnull info;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithLatitude:(double)latitude longitude:(double)longitude name:(NSString * __nonnull)name info:(NSString * __nonnull)info OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithData:(NSDictionary * __nonnull)data OBJC_DESIGNATED_INITIALIZER;
@end


@interface UdacityStudent (SWIFT_EXTENSION(OnTheMap)) <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString * __nonnull title;
@property (nonatomic, readonly, copy) NSString * __nullable subtitle;
@end

@class WKWebView;
@class UINavigationBar;

SWIFT_CLASS("_TtC8OnTheMap21UdacityViewController")
@interface UdacityViewController : UIViewController <WKNavigationDelegate>
@property (nonatomic) WKWebView * __nullable wkWebView;
@property (nonatomic, copy) NSString * __nullable urlString;
@property (nonatomic, weak) IBOutlet UINavigationBar * __null_unspecified navBar;
- (IBAction)cancelTapped:(id __nonnull)sender;
- (void)viewDidLoad;
- (void)wkWebViewConfig;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
