//
//  ViewController.m
//  Nature
//
//  Created by Tope Abayomi on 03/09/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray* imageViews;

@property (nonatomic, strong) UIImageView* visibleImageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageViews = [NSMutableArray array];
    
    NSArray* images = @[@"amazonas", @"billow", @"candela", @"canyon", @"niagara", @"sky", @"sunrise"];

    for (NSString* imageName in images) {
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];

        imageView.image = [UIImage imageNamed:imageName];
        imageView.alpha = 0.0;
        
        [self.view insertSubview:imageView belowSubview:self.scrollView];
        
        [self.imageViews addObject:imageView];
    }
    
    self.visibleImageView = self.imageViews[0];
    self.visibleImageView.alpha = 1.0;
    
    
    [self.button addTarget:self action:@selector(swichVisibleImageView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.button setTitle:@"Tap to Switch Background" forState:UIControlStateNormal];

    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGesture];
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(changeSettings:)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self setupElements];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.visibleImageView.alpha = 0.0;
    [Utils customizeView:self.view];
}

-(void)tapped{
    [self swichVisibleImageView];
}

-(void)swichVisibleImageView{
    
    int index = [self.imageViews indexOfObject:self.visibleImageView];
    
    index++;
    index = index % self.imageViews.count;
    
    UIImageView* visible = self.imageViews[index];
    
     [UIView animateWithDuration:1.0 animations:^{
         
         self.visibleImageView.alpha = 0.0;
         visible.alpha = 1.0;
         
     } completion:^(BOOL finished) {
         self.visibleImageView = visible;
     }];
}


-(void)setupElements{
    
    UIColor* mainColor =[UIColor whiteColor];
    UIColor* imageBorderColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:0.4f];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    NSString* boldFontName = @"Avenir-Black";
    
    
    self.nameLabel.textColor =  mainColor;
    self.nameLabel.font =  [UIFont fontWithName:boldItalicFontName size:18.0f];
    self.nameLabel.text = @"Maria Llewellyngot";
    
    self.usernameLabel.textColor =  mainColor;
    self.usernameLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.usernameLabel.text = @"@llewellyngot";
    
    UIFont* countLabelFont = [UIFont fontWithName:boldItalicFontName size:20.0f];
    UIColor* countColor = mainColor;
    
    self.followerCountLabel.textColor =  countColor;
    self.followerCountLabel.font =  countLabelFont;
    self.followerCountLabel.text = @"132k";
    
    self.followingCountLabel.textColor =  countColor;
    self.followingCountLabel.font =  countLabelFont;
    self.followingCountLabel.text = @"200";
    
    self.updateCountLabel.textColor =  countColor;
    self.updateCountLabel.font =  countLabelFont;
    self.updateCountLabel.text = @"20k";
    
    UIFont* socialFont = [UIFont fontWithName:boldItalicFontName size:10.0f];
    
    self.followerLabel.textColor =  mainColor;
    self.followerLabel.font =  socialFont;
    self.followerLabel.text = @"FOLLOWERS";
    
    self.followingLabel.textColor =  mainColor;
    self.followingLabel.font =  socialFont;
    self.followingLabel.text = @"FOLLOWING";
    
    self.updateLabel.textColor =  mainColor;
    self.updateLabel.font =  socialFont;
    self.updateLabel.text = @"UPDATES";
    
    
    self.bioLabel.textColor =  mainColor;
    self.bioLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.bioLabel.text = @"Founder, CEO of Mavin Records, Entrepreneur mom and action gal";
    
    self.friendLabel.textColor =  mainColor;
    self.friendLabel.font =  [UIFont fontWithName:boldFontName size:18.0f];;
    self.friendLabel.text = @"Friends";
    
    self.profileImageView.image = [UIImage imageNamed:@"profile.jpg"];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.cornerRadius = 55.0f;
    self.profileImageView.layer.borderColor = imageBorderColor.CGColor;
    
    [self styleFriendProfileImage:self.friendImageView1 withImageNamed:@"profile-1.jpg" andColor:imageBorderColor];
    [self styleFriendProfileImage:self.friendImageView2 withImageNamed:@"profile-2.jpg" andColor:imageBorderColor];
    [self styleFriendProfileImage:self.friendImageView3 withImageNamed:@"profile-3.jpg" andColor:imageBorderColor];
    
    [self addDividerToView:self.scrollView atLocation:230];
    [self addDividerToView:self.scrollView atLocation:300];
    [self addDividerToView:self.scrollView atLocation:370];
    
    self.scrollView.contentSize = CGSizeMake(320, 800);
    self.scrollView.backgroundColor = [UIColor clearColor];

}


-(void)styleFriendProfileImage:(UIImageView*)imageView withImageNamed:(NSString*)imageName andColor:(UIColor*)color{
    
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 4.0f;
    imageView.layer.borderColor = color.CGColor;
    imageView.layer.cornerRadius = 35.0f;
}

-(void)addDividerToView:(UIView*)view atLocation:(CGFloat)location{
    
    UIView* divider = [[UIView alloc] initWithFrame:CGRectMake(20, location, 280, 1)];
    divider.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.7f];
    [view addSubview:divider];
}

-(void)changeSettings:(id)sender{
    
    [self performSegueWithIdentifier:@"settings" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
