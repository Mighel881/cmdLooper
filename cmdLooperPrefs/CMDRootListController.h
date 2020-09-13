#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface CMDRootListController : PSListController
- (NSMutableArray *)specifiers;
- (id)readPreferenceValue:(PSSpecifier *)specifier;
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier;
@end
