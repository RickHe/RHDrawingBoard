//
//  ViewController.m
//  XYDrawingBoard
//
//  Created by hmy2015 on 16/4/5.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "ViewController.h"
#import "Board.h"
#import "PencilBrush.h"
#import "LineBrush.h"
#import "DashLineBrush.h"
#import "RectangleBrush.h"
#import "EllipseBrush.h"
#import "EraserBrush.h"
#import "PaintingBrushSettingView.h"
#import "BackgroundSettingsView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
{
    NSArray *_toolbarEditingItems;
    UIView *_currentSettingsView;
    NSArray *_brushes;
    BOOL _isBackgroundSettingViewEditing;
    BOOL _isPaintingSettingViewEditing;
    BOOL _isDrawing;
}

@property (weak, nonatomic) IBOutlet Board *board;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;
@property (weak, nonatomic) IBOutlet UIButton *redoButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomLayoutConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isPaintingSettingViewEditing = NO;
    _isPaintingSettingViewEditing = NO;
    _isDrawing = NO;
    _brushes = @[[PencilBrush new],
                 [LineBrush new],
                 [DashLineBrush new],
                 [RectangleBrush new],
                 [EllipseBrush new],
                 [EraserBrush new]];
    self.board.brush = _brushes[0];
    _toolbarEditingItems = @[
                             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
    [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(endSetting)]
                            ];
    self.toolbarItems = self.toolBar.items;
    
    [self p_setupBrushSettingsView];
    [self p_setupBackgroundSettingsView];
    __weak __typeof(self)weakSelf = self;
    self.board.drawingStateChangedBlock = ^(kDrawingState state) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (state != kDrawingStateMoved) {
            if (state == kDrawingStateBegin) {
                [UIView animateWithDuration:.5 animations:^{
                    CGRect frame = self.topView.frame;
                    frame.origin.y = -self.topView.frame.size.height;
                    weakSelf.topView.frame = frame;
                    
                    CGRect frame1 = self.toolBar.frame;
                    frame1.origin.y = kScreenHeight;
                    weakSelf.toolBar.frame = frame1;
                    
                    [weakSelf p_brushSettingsViewHide];
                    [weakSelf p_backgroundSettingViewHide];
                    strongSelf->_isDrawing = YES;
                    weakSelf.undoButton.alpha = 0;
                    weakSelf.redoButton.alpha = 0;
                }];

            } else if (state == kDrawingStateEnd) {
                [UIView animateWithDuration:.5 animations:^{
                    CGRect frame = self.topView.frame;
                    frame.origin.y = 0;
                    weakSelf.topView.frame = frame;
                    
                    CGRect frame1 = self.toolBar.frame;
                    frame1.origin.y = kScreenHeight - self.toolBar.frame.size.height;
                    weakSelf.toolBar.frame = frame1;
                    
                    if (strongSelf->_isPaintingSettingViewEditing && strongSelf->_isDrawing) {
                        [weakSelf p_brushSettingsViewShow];
                    }
                    if (strongSelf->_isBackgroundSettingViewEditing && strongSelf->_isDrawing) {
                        [weakSelf p_backgroundSettingViewShow];
                    }
                    
                    weakSelf.undoButton.alpha = 1;
                    weakSelf.redoButton.alpha = 1;
                }];
            }
        }

    };
}

#pragma mark - Private
- (void)p_setupBrushSettingsView {
    NSArray *arr = [[UINib nibWithNibName:@"PaintingBrushSettingView" bundle:nil]instantiateWithOwner:nil options:nil];
    PaintingBrushSettingView *brushSettingsView = (PaintingBrushSettingView *)[arr firstObject];
     brushSettingsView.frame = CGRectMake(0, kScreenHeight - 250 - 44, kScreenWidth, 250);
    brushSettingsView.hidden = YES;
    brushSettingsView.tag = 101;
    [self.view addSubview:brushSettingsView];
    brushSettingsView.backgroundColor = [UIColor colorWithRed:232.0 / 255 green:232.0 / 255 blue:232.0 / 255 alpha:1];
    __weak __typeof__(self)weakSelf = self;
    brushSettingsView.strokeWidthChangedBlock = ^(CGFloat strokeWidth){
        weakSelf.board.strokeWidth = strokeWidth;
    };
    
    brushSettingsView.strokeColorChangedBlock = ^(UIColor *strokeColor){
        weakSelf.board.strokeColor = strokeColor;
    };
}

- (void)p_backgroundSettingViewHide {
    BackgroundSettingsView *backgourndSetting = (BackgroundSettingsView *)[self.view viewWithTag:102];
    backgourndSetting.hidden = YES;
}

- (void)p_backgroundSettingViewShow {
    BackgroundSettingsView *backgourndSetting = (BackgroundSettingsView *)[self.view viewWithTag:102];
    backgourndSetting.hidden = NO;
}

- (void)p_brushSettingsViewHide {
    PaintingBrushSettingView *paintBrushSetting = (PaintingBrushSettingView *)[self.view viewWithTag:101];
    paintBrushSetting.hidden = YES;
}

- (void)p_brushSettingsViewShow {
    PaintingBrushSettingView *paintBrushSetting = (PaintingBrushSettingView *)[self.view viewWithTag:101];
    paintBrushSetting.hidden = NO;
}

- (void)p_setupBackgroundSettingsView {
    NSArray *arr = [[UINib nibWithNibName:@"BackgroundSettingsView" bundle:nil] instantiateWithOwner:nil options:nil];
    BackgroundSettingsView *backgroundSettingsView = (BackgroundSettingsView *)[arr firstObject];
    backgroundSettingsView.frame = CGRectMake(0, kScreenHeight - 180 - 44, kScreenWidth, 180);
    backgroundSettingsView.hidden = YES;
    backgroundSettingsView.tag = 102;
    [self.view addSubview:backgroundSettingsView];
    backgroundSettingsView.backgroundColor = [UIColor colorWithRed:232.0 / 255 green:232.0 / 255 blue:232.0 / 255 alpha:1];
    __weak __typeof__(self)weakSelf = self;
    backgroundSettingsView.backgroundImageChangedBlock = ^(UIImage *backgroundImage){
        weakSelf.board.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    };
    
    backgroundSettingsView.backgroundColorChangedBlock = ^(UIColor *backgroundColor){
        weakSelf.board.backgroundColor = backgroundColor;
    };
}

#pragma mark - Button Action
- (void)endSetting {
    _isDrawing = NO;
    _isBackgroundSettingViewEditing = NO;
    _isPaintingSettingViewEditing = NO;
    [UIView animateWithDuration:0.6 animations:^{
        [self.toolBar setItems:self.toolbarItems];
        [self p_brushSettingsViewHide];
        [self p_backgroundSettingViewHide];
        CGRect frame1 = self.toolBar.frame;
        frame1.origin.y = kScreenHeight - 44;
        frame1.size.height = 44;
        self.toolBar.frame = frame1;
    }];
}

#pragma mark - Storyboard Action
- (IBAction)switchBrush:(UISegmentedControl *)sender {
    self.board.brush = _brushes[sender.selectedSegmentIndex];
}

- (IBAction)undo:(UIButton *)sender {
    [self.board undo];
}

- (IBAction)redo:(id)sender {
    [self.board redo];
}

- (IBAction)paintingBrushSetting:(id)sender {
    _isPaintingSettingViewEditing = YES;
    _isDrawing = NO;
    [self.toolBar setItems:_toolbarEditingItems];
    PaintingBrushSettingView *paintBrushSetting = (PaintingBrushSettingView *)[self.view viewWithTag:101];
    paintBrushSetting.hidden = NO;
}

- (IBAction)backgourndSetting:(id)sender {
    _isBackgroundSettingViewEditing = YES;
    _isDrawing = NO;
    [self.toolBar setItems:_toolbarEditingItems];
    BackgroundSettingsView *backgourndSetting = (BackgroundSettingsView *)[self.view viewWithTag:102];
    backgourndSetting.hidden = NO;
}

- (IBAction)saveToAlbum:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.board.takeImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - Others
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *message;
    if (error != NULL){
        //失败
        message = @"保存失败";
    }
    else{
        //成功
        message = @"保存成功";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
