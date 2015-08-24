#import <Preferences/Preferences.h>
#import <Social/Social.h>

#define UIColorRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface FastFreezeBanner : PSTableCell
@end

@implementation FastFreezeBanner

- (id)initWithStyle:(int)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fastFreezeBannerCell" specifier:specifier];

    if (self) {
        self.backgroundColor = UIColorRGB(74, 74, 74);

        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 206)];
        label.font = [UIFont fontWithName:@"Helvetica-Light" size:60];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = @"#pantarhei";

        [self addSubview:label];
    }

    return self;
}

@end

@interface FastFreezeSettingsListController : PSListController
@end

@implementation FastFreezeSettingsListController

- (id)specifiers
{
    if (_specifiers == nil) _specifiers = [self loadSpecifiersFromPlistName:@"FastFreeze" target:self];

    return _specifiers;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  UIButton *tweetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  [tweetButton setImage:[[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/FastFreezeSettings.bundle/Heart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
  [tweetButton sizeToFit];
  [tweetButton setTintColor:UIColorRGB(74, 74, 74)];
  [tweetButton addTarget:self action:@selector(handleTweet) forControlEvents:UIControlEventTouchUpInside];
  [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:tweetButton]];
}

- (void)handleTweet
{
  SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
  [composeController setInitialText:@"I’m using Fast Freeze by @biscoditch for a better battery life of my device!"];
  [self presentViewController:composeController animated:YES completion:nil];
}

- (void)openTwitter
{
  NSString *username = @"biscoditch";

  if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", username]]];
  } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitterrific:///profile?screen_name=%@", username]]];
  } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tweetings:///user?screen_name=%@", username]]];
  } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", username]]];
  } else {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://mobile.twitter.com/%@", username]]];
  }
}

- (void)openGithub
{
  NSString *username = @"shinvou";

  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/%@", username]]];
}

@end
