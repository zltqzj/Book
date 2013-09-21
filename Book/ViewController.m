//
//  ViewController.m
//  Book
//
//  Created by ZKR on 9/21/13.
//  Copyright (c) 2013 ZKR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    BOOL right;
    UIBarButtonItem* rightBarButton;
    int count ;
    CGSize winSize;
    
}

@end

@implementation ViewController
@synthesize str = _str;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 加载str中的内容
    _str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ai" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    // 导航栏右侧按钮
    rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"翻页" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    // textView 加载
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:textView];
    textView.text = _str;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:19];
    textView.textColor = [UIColor blackColor];
    textView.editable = NO;
    winSize = textView.contentSize;
    NSLog(@"%f",textView.contentSize.height);
    
    allPage = textView.contentSize.height/430 + 1;
    currentPage = 1;
    textView.contentSize = self.view.frame.size;
    self.title = [NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    
    
    // 手势
    // 单击手势
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    // 左轻扫手势
    UISwipeGestureRecognizer* leftswipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(LeftswipeGestureAction:)];
    leftswipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    leftswipeGesture.delegate = self;
    [self.view addGestureRecognizer:leftswipeGesture];
    
    
    // 右轻扫手势
    UISwipeGestureRecognizer* rightswipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(RightswipeGestureAction:)];
    rightswipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    rightswipeGesture.delegate = self;
    [self.view addGestureRecognizer:rightswipeGesture];
}

// 导航栏右侧按钮触发事件
-(void)rightButton
{
    if (right == NO) {
        rightBarButton.title = @"下滑";
        right = YES;
        textView.contentSize = winSize;
    }else{
        rightBarButton.title = @"翻页";
        right = NO;
        textView.contentSize = self.view.frame.size;
    }
}
// 单击页面
-(void)tapGestureAction:(UITapGestureRecognizer*)tapGesture{
    NSLog(@"点击页面");
    if ( count++ %2 ==0 ) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
}

// 左滑
-(void)LeftswipeGestureAction:(UISwipeGestureRecognizer*)swipeGesture{
    
    if (currentPage == allPage) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已是最后一页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    currentPage = currentPage +1;
    NSLog(@"当前页：%d",currentPage);
    self.title = [NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    
    // animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [textView setContentOffset:CGPointMake(0, (currentPage -1) *430) animated:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [UIView commitAnimations];
    
    return;
    
    
    
    
    
    
}

// 右滑
-(void)RightswipeGestureAction:(UISwipeGestureRecognizer*)swipeGesture{
    if (currentPage == 1) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"这已是第一页" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        return;
    }
    currentPage = currentPage - 1;
    NSLog(@"%d",currentPage);
    self.title = [NSString stringWithFormat:@"%d/%d",currentPage,allPage];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [textView setContentOffset:CGPointMake(0, (currentPage - 1) * 430) animated:YES];
    [UIView commitAnimations];
    //
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    
    [UIView commitAnimations];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"开始滑动");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"停止滑动");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"停止拖拽");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
