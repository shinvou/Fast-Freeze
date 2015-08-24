#import "substrate.h"

#import <libactivator/libactivator.h>

//#define LOGGING_ENABLED

#ifdef LOGGING_ENABLED
  #define log(format, ...) NSLog(@"[Fast Freeze] %@", [NSString stringWithFormat:format, ## __VA_ARGS__])
#else
  #define log(format, ...)
#endif

@interface FastFreezeAction : NSObject <LAListener>
@end

@interface SBUIController
- (BOOL)isAppSwitcherShowing;
- (void)_dismissSwitcherAnimated:(BOOL)animated;
@end

@interface SBAppSwitcherModel : NSObject
+ (id)sharedInstance;
- (id)snapshot;
- (void)remove:(id)arg1;
@end

@interface BKSProcess : NSObject
- (void)_handleExpirationWarning:(id)xpcdictionary;
@end

@interface FBApplicationProcess : NSObject {
	BKSProcess *_bksProcess;
}
@end

@interface SpringBoard : UIApplication
@property (nonatomic, retain, readonly) id _accessibilityRunningApplications;
@end
