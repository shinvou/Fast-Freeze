#import "FastFreeze.h"

@implementation FastFreezeAction

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName
{
  return @"Fast Freeze";
}

- (NSString *)activator:(id)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName
{
  return @"Freeze them, bitch";
}

- (NSString *)activator:(id)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName
{
  return @"Freeze all selected apps in memory";
}

- (BOOL)activator:(LAActivator *)activator requiresNeedsPoweredDisplayForListenerName:(NSString *)listenerName
{
  return NO;
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
  CFPreferencesAppSynchronize(CFSTR("com.shinvou.fastfreeze"));
  BOOL allowRemove = [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("allowRemove"), CFSTR("com.shinvou.fastfreeze"))) boolValue];

  if (allowRemove) [self removeThem];

  [self freezeThem];

  [event setHandled:YES];
}

- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale
{
  return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/FastFreezeSettings.bundle/FastFreeze.png"];
}

- (void)removeThem
{
	if ([[objc_getClass("SBUIController") sharedInstance] isAppSwitcherShowing]) {
		[[objc_getClass("SBUIController") sharedInstance] _dismissSwitcherAnimated:YES];
	}

	NSArray *applications = [[objc_getClass("SBAppSwitcherModel") sharedInstance] snapshot];

	for (int i = 0; i < applications.count; i++) {
		[[objc_getClass("SBAppSwitcherModel") sharedInstance] remove:[applications objectAtIndex:i]];
	}
}

- (void)freezeThem
{
  NSArray *runningApplications = ((SpringBoard *)[UIApplication sharedApplication])._accessibilityRunningApplications;

  for (int i = 0; i < runningApplications.count; i++) {
    NSString *bundleIdentifier = [[runningApplications objectAtIndex:i] bundleIdentifier];
    NSString *bundleIdentifierSettings = [NSString stringWithFormat:@"FastFreezeEnabled:%@", bundleIdentifier];

    CFPreferencesAppSynchronize(CFSTR("com.shinvou.fastfreeze"));
    Boolean exists;
    Boolean enabled = CFPreferencesGetAppBooleanValue((CFStringRef)bundleIdentifierSettings, CFSTR("com.shinvou.fastfreeze"), &exists);

    if (!exists || (exists && enabled)) {
      FBApplicationProcess *applicationProcess = [[runningApplications objectAtIndex:i] valueForKey:@"_process"];
      BKSProcess *applicationBKSProcess = [applicationProcess valueForKey:@"_bksProcess"];
      [applicationBKSProcess _handleExpirationWarning:nil];
    }
  }
}

@end

%ctor {
	@autoreleasepool {
		[[objc_getClass("LAActivator") sharedInstance] registerListener:[[FastFreezeAction alloc] init] forName:@"com.shinvou.fastfreeze.freezethebitches"];
	}
}
