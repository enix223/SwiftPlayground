//
//  TestTableViewSearchController.m
//  SwiftPlayground
//
//  Created by Enix Yu on 6/11/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

#import "TestTableViewSearchController.h"

@implementation Restaurant

- (instancetype)init:(NSString *)title descripiton:(NSString *)description image:(NSString *)image {
    self = [super init];
    if (self != nil) {
        self.title = title;
        self.desc = description;
        self.image = image;
    }
    return self;
}

@end

@implementation RestTableViewCell
@end

@implementation RestViewController
@end

@interface MainTableViewController ()

@property (nonatomic, strong) NSArray<Restaurant *> *originData;
@property (nonatomic, strong) NSMutableArray<Restaurant *> *filteredRest;
@property (nonatomic, assign) Boolean isFiltered;

@end


@implementation MainTableViewController

@synthesize mySearchBar, filteredRest, isFiltered, originData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    originData = @[
                    [[Restaurant alloc] init:@"80 Grados" descripiton:@"Barrio Malasaña" image:@"80_grados.png"],
                    [[Restaurant alloc] init:@"90 Grados" descripiton:@"Barrio Retiro" image:@"90_grados"]
                    ];
    filteredRest = [NSMutableArray new];
    isFiltered = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return _Title.count;
    
    if (isFiltered == YES) {
        return filteredRest.count;
    } else {
        return originData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    RestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (isFiltered == YES) {
        cell.TitleLabel.text = [filteredRest objectAtIndex:indexPath.row].title;
        cell.DescriptionLabel.text = [filteredRest objectAtIndex:indexPath.row].desc;
        cell.RestImage.image = [UIImage imageNamed:[filteredRest objectAtIndex:indexPath.row].image];
    } else {
        cell.TitleLabel.text = [originData objectAtIndex:indexPath.row].title;
        cell.DescriptionLabel.text = [originData objectAtIndex:indexPath.row].desc;
        cell.RestImage.image = [UIImage imageNamed:[originData objectAtIndex:indexPath.row].image];
    }
    
    cell.RestImage.layer.cornerRadius = 6;
    cell.RestImage.clipsToBounds = YES;
    cell.RestImage.layer.borderWidth = 1;
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*Cambia el nombre del boton de la izquierda sin afectar al titulo del navigation controller*/
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle: NSLocalizedString (@"Back", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if ([[segue identifier] isEqualToString:@"ShowDetails"]){
        RestViewController *restviewcontroller = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        if (isFiltered) {
            restviewcontroller.DetailModal = filteredRest[myIndexPath.row];
        } else {
            restviewcontroller.DetailModal = originData[myIndexPath.row];
        }
    }
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        //Set our boolean flag
        isFiltered = NO;
    } else {
        //Set our boolean flag
        isFiltered = YES;
    }
    //Alloc and init our filteredData
    filteredRest = [[NSMutableArray alloc] init];
    
    for (Restaurant *item in originData) {
        if ([item.title containsString:searchText]) {
            [filteredRest addObject:item];
        }
    }

    //Reload our table view
    [self.tableView reloadData];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [mySearchBar resignFirstResponder];
}

@end
