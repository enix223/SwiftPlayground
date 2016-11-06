//
//  TestTableViewSearchController.h
//  SwiftPlayground
//
//  Created by Enix Yu on 6/11/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Restaurant;

@interface Restaurant : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *image;

- (instancetype)init:(NSString *)title descripiton:(NSString *)description image:(NSString *)image;

@end


@interface MainTableViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UISearchBar *mySearchBar;

@end


@interface RestTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *TitleLabel;
@property (nonatomic, weak) UILabel *DescriptionLabel;
@property (nonatomic, weak) UIImageView *RestImage;

@end


@interface RestViewController : UIViewController

@property (nonatomic, strong) Restaurant *DetailModal;

@end
