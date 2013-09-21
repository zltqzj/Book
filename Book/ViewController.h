//
//  ViewController.h
//  Book
//
//  Created by ZKR on 9/21/13.
//  Copyright (c) 2013 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    UITextView* textView;
    int currentPage;
    int allPage;
}

// 书中的内容
@property(nonatomic,strong) NSString* str;


@end
