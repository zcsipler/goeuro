//
//  ViewController.h
//  GoEuro
//
//  Created by Zoltan Csipler on 16/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CountryService.h"

@interface ViewController : UIViewController

@property(nonatomic,strong) CountryService *countryService;
@property(nonatomic,copy) NSArray *countryList;
@property (nonatomic,strong) UITextField *txtFieldActive;

@property (weak, nonatomic) IBOutlet UITableView *tableViewCountries;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTableViewYPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblSearchResult;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

- (IBAction)searchButtonPressed:(id)sender;

@end

