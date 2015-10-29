//
//  UIActionSheet+Block.m
//  star
//
//  Created by lt on 15/3/12.
//  Copyright (c) 2015年 zxmeng. All rights reserved.
//

#import "UIActionSheet+Block.h"

#import <objc/runtime.h>

static const void *UIActionSheetOriginalDelegateKey = &UIActionSheetOriginalDelegateKey;

static const void *UIActionSheetTapBlockKey         = &UIActionSheetTapBlockKey;
static const void *UIActionSheetWillPresentBlockKey = &UIActionSheetWillPresentBlockKey;
static const void *UIActionSheetDidPresentBlockKey  = &UIActionSheetDidPresentBlockKey;
static const void *UIActionSheetWillDismissBlockKey = &UIActionSheetWillDismissBlockKey;
static const void *UIActionSheetDidDismissBlockKey  = &UIActionSheetDidDismissBlockKey;
static const void *UIActionSheetCancelBlockKey      = &UIActionSheetCancelBlockKey;

#define NSArrayObjectMaybeNil(__ARRAY__, __INDEX__) ((__INDEX__ >= [__ARRAY__ count]) ? nil : [__ARRAY__ objectAtIndex:__INDEX__])
// This is a hack to turn an array into a variable argument list. There is no good way to expand arrays into variable argument lists in Objective-C. This works by nil-terminating the list as soon as we overstep the bounds of the array. The obvious glitch is that we only support a finite number of buttons.
#define NSArrayToVariableArgumentsList(__ARRAYNAME__) NSArrayObjectMaybeNil(__ARRAYNAME__, 0), NSArrayObjectMaybeNil(__ARRAYNAME__, 1), NSArrayObjectMaybeNil(__ARRAYNAME__, 2), NSArrayObjectMaybeNil(__ARRAYNAME__, 3), NSArrayObjectMaybeNil(__ARRAYNAME__, 4), NSArrayObjectMaybeNil(__ARRAYNAME__, 5), NSArrayObjectMaybeNil(__ARRAYNAME__, 6), NSArrayObjectMaybeNil(__ARRAYNAME__, 7), NSArrayObjectMaybeNil(__ARRAYNAME__, 8), NSArrayObjectMaybeNil(__ARRAYNAME__, 9), nil

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation UIActionSheet (Blocks)

+ (instancetype)showFromTabBar:(UITabBar *)tabBar
                     withTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
             otherButtonTitles:(NSArray *)otherButtonTitles
                      tapBlock:(UIActionSheetCompletionBlock)tapBlock {
    
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title
                                                    delegate:nil
                                           cancelButtonTitle:cancelButtonTitle
                                      destructiveButtonTitle:destructiveButtonTitle
                                           otherButtonTitles:NSArrayToVariableArgumentsList(otherButtonTitles)];
    
    if (tapBlock) {
        actionSheet.tapBlock = tapBlock;
    }
    
    [actionSheet showFromTabBar:tabBar];
    
#if !__has_feature(objc_arc)
    return [actionSheet autorelease];
#else
    return actionSheet;
#endif
}

+ (instancetype)showFromToolbar:(UIToolbar *)toolbar
                      withTitle:(NSString *)title
              cancelButtonTitle:(NSString *)cancelButtonTitle
         destructiveButtonTitle:(NSString *)destructiveButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles
                       tapBlock:(UIActionSheetCompletionBlock)tapBlock {
    
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title
                                                    delegate:nil
                                           cancelButtonTitle:cancelButtonTitle
                                      destructiveButtonTitle:destructiveButtonTitle
                                           otherButtonTitles:NSArrayToVariableArgumentsList(otherButtonTitles)];
    
    if (tapBlock) {
        actionSheet.tapBlock = tapBlock;
    }
    
    [actionSheet showFromToolbar:toolbar];
    
#if !__has_feature(objc_arc)
    return [actionSheet autorelease];
#else
    return actionSheet;
#endif
}

+ (instancetype)showInView:(UIView *)view
                 withTitle:(NSString *)title
         cancelButtonTitle:(NSString *)cancelButtonTitle
    destructiveButtonTitle:(NSString *)destructiveButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                  tapBlock:(UIActionSheetCompletionBlock)tapBlock {
    
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title
                                                    delegate:nil
                                           cancelButtonTitle:cancelButtonTitle
                                      destructiveButtonTitle:destructiveButtonTitle
                                           otherButtonTitles:NSArrayToVariableArgumentsList(otherButtonTitles)];
    
    if (tapBlock) {
        actionSheet.tapBlock = tapBlock;
    }
    
    [actionSheet showInView:view];
    
#if !__has_feature(objc_arc)
    return [actionSheet autorelease];
#else
    return actionSheet;
#endif
}

+ (instancetype)showFromBarButtonItem:(UIBarButtonItem *)barButtonItem
                             animated:(BOOL)animated
                            withTitle:(NSString *)title
                    cancelButtonTitle:(NSString *)cancelButtonTitle
               destructiveButtonTitle:(NSString *)destructiveButtonTitle
                    otherButtonTitles:(NSArray *)otherButtonTitles
                             tapBlock:(UIActionSheetCompletionBlock)tapBlock {
    
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title
                                                    delegate:nil
                                           cancelButtonTitle:cancelButtonTitle
                                      destructiveButtonTitle:destructiveButtonTitle
                                           otherButtonTitles:NSArrayToVariableArgumentsList(otherButtonTitles)];
    
    if (tapBlock) {
        actionSheet.tapBlock = tapBlock;
    }
    
    [actionSheet showFromBarButtonItem:barButtonItem animated:animated];
    
#if !__has_feature(objc_arc)
    return [actionSheet autorelease];
#else
    return actionSheet;
#endif
}

+ (instancetype)showFromRect:(CGRect)rect
                      inView:(UIView *)view
                    animated:(BOOL)animated
                   withTitle:(NSString *)title
           cancelButtonTitle:(NSString *)cancelButtonTitle
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
           otherButtonTitles:(NSArray *)otherButtonTitles
                    tapBlock:(UIActionSheetCompletionBlock)tapBlock {
    
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title
                                                    delegate:nil
                                           cancelButtonTitle:cancelButtonTitle
                                      destructiveButtonTitle:destructiveButtonTitle
                                           otherButtonTitles:NSArrayToVariableArgumentsList(otherButtonTitles)];
    
    if (tapBlock) {
        actionSheet.tapBlock = tapBlock;
    }
    
    [actionSheet showFromRect:rect inView:view animated:animated];
    
#if !__has_feature(objc_arc)
    return [actionSheet autorelease];
#else
    return actionSheet;
#endif
}

#pragma mark -

- (void)_checkActionSheetDelegate {
    if (self.delegate != (id<UIActionSheetDelegate>)self) {
        objc_setAssociatedObject(self, UIActionSheetOriginalDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UIActionSheetDelegate>)self;
    }
}

- (UIActionSheetCompletionBlock)tapBlock {
    return objc_getAssociatedObject(self, UIActionSheetTapBlockKey);
}

- (void)setTapBlock:(UIActionSheetCompletionBlock)tapBlock {
    [self _checkActionSheetDelegate];
    objc_setAssociatedObject(self, UIActionSheetTapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY);
}

- (UIActionSheetCompletionBlock)willDismissBlock {
    return objc_getAssociatedObject(self, UIActionSheetWillDismissBlockKey);
}

- (void)setWillDismissBlock:(UIActionSheetCompletionBlock)willDismissBlock {
    [self _checkActionSheetDelegate];
    objc_setAssociatedObject(self, UIActionSheetWillDismissBlockKey, willDismissBlock, OBJC_ASSOCIATION_COPY);
}

- (UIActionSheetCompletionBlock)didDismissBlock {
    return objc_getAssociatedObject(self, UIActionSheetDidDismissBlockKey);
}

- (void)setDidDismissBlock:(UIActionSheetCompletionBlock)didDismissBlock {
    [self _checkActionSheetDelegate];
    objc_setAssociatedObject(self, UIActionSheetDidDismissBlockKey, didDismissBlock, OBJC_ASSOCIATION_COPY);
}

- (UIActionSheetBlock)willPresentBlock {
    return objc_getAssociatedObject(self, UIActionSheetWillPresentBlockKey);
}

- (void)setWillPresentBlock:(UIActionSheetBlock)willPresentBlock {
    [self _checkActionSheetDelegate];
    objc_setAssociatedObject(self, UIActionSheetWillPresentBlockKey, willPresentBlock, OBJC_ASSOCIATION_COPY);
}

- (UIActionSheetBlock)didPresentBlock {
    return objc_getAssociatedObject(self, UIActionSheetDidPresentBlockKey);
}

- (void)setDidPresentBlock:(UIActionSheetBlock)didPresentBlock {
    [self _checkActionSheetDelegate];
    objc_setAssociatedObject(self, UIActionSheetDidPresentBlockKey, didPresentBlock, OBJC_ASSOCIATION_COPY);
}

- (UIActionSheetBlock)cancelBlock {
    return objc_getAssociatedObject(self, UIActionSheetCancelBlockKey);
}

- (void)setCancelBlock:(UIActionSheetBlock)cancelBlock {
    [self _checkActionSheetDelegate];
    objc_setAssociatedObject(self, UIActionSheetCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - UIActionSheetDelegate

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    UIActionSheetBlock completion = actionSheet.willPresentBlock;
    
    if (completion) {
        completion(actionSheet);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIActionSheetOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [originalDelegate willPresentActionSheet:actionSheet];
    }
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
    UIActionSheetBlock completion = actionSheet.didPresentBlock;
    
    if (completion) {
        completion(actionSheet);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIActionSheetOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(didPresentActionSheet:)]) {
        [originalDelegate didPresentActionSheet:actionSheet];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIActionSheetCompletionBlock completion = actionSheet.tapBlock;
    
    if (completion) {
        completion(actionSheet, buttonIndex);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIActionSheetOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [originalDelegate actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    UIActionSheetBlock completion = actionSheet.cancelBlock;
    
    if (completion) {
        completion(actionSheet);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIActionSheetOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [originalDelegate actionSheetCancel:actionSheet];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIActionSheetCompletionBlock completion = actionSheet.willDismissBlock;
    
    if (completion) {
        completion(actionSheet, buttonIndex);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIActionSheetOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        [originalDelegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIActionSheetCompletionBlock completion = actionSheet.didDismissBlock;
    
    if (completion) {
        completion(actionSheet, buttonIndex);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIActionSheetOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
        [originalDelegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
    }
}

@end
#pragma clang diagnostic pop