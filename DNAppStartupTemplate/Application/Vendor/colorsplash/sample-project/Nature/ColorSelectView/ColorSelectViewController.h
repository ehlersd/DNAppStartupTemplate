//
//  ColorSelectViewController.h
//
//
//  Created by Valentin Filip on 8/1/13.
//  Copyright (c) 2013 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerViewController.h"


@interface ColorSelectViewController : UIViewController <ColorPickerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView* tableView;

@end
