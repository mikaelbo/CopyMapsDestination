@interface MapsThemeLabel : UILabel
- (void)MB_configureForLongPress;
@end

%hook MapsThemeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
    [self MB_configureForLongPress];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = %orig;
    [self MB_configureForLongPress];
    return self;
}

%new
- (void)MB_configureForLongPress {
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(MB_handleLongPress:)]];
    self.userInteractionEnabled = YES;
}

%new
- (void)MB_handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan) { return; }
    [self becomeFirstResponder];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setTargetRect:self.frame inView:self.superview];
    [menuController setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(copy:) ? YES : %orig;
}

%new
- (void)copy:(id)sender {
    [[UIPasteboard generalPasteboard] setString:self.text];
}

%end
