//
//  ViewController.m
//  GoEuro
//
//  Created by Zoltan Csipler on 16/06/16.
//  Copyright © 2016 Zoltan Csipler. All rights reserved.
//

#import "ViewController.h"

#import "CountryCell.h"

static NSString * const SEARCH_NOT_IMPLEMENTED = @"Search is not yet implemented";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewCountries.backgroundColor = [UIColor clearColor];
    self.countryService = [CountryService new];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *keyword = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%@", keyword);
    [self.countryService getCountryNamesWithKeyword:keyword resultBlock:^(NSArray *countryList) {
        self.countryList = countryList;
        if (self.countryList.count > 0)
        {
             [self.tableViewCountries reloadData];
            self.txtFieldActive = textField;
            [self moveCountriesListToActiveTextfield];
            
            [self fadeInCountriesTableView];
        }
        else
        {
            [self fadeOutCountriesTableView];
        }
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self fadeOutCountriesTableView];
    
    UITextField *txtFrom = (UITextField *)[self.view viewWithTag:1];
    UITextField *txtTo = (UITextField *)[self.view viewWithTag:2];
    if (textField.tag == 1)
    {
        [txtTo becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        if (txtFrom.text.length > 0 && txtTo.text.length > 0)
        {
            self.btnSearch.hidden = NO;
        }
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *countryCellIdentifier = @"countryCell";
    
    CountryCell *countryCell = [tableView dequeueReusableCellWithIdentifier:countryCellIdentifier];
    
    if (countryCell == nil)
    {
        countryCell = [[CountryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:countryCellIdentifier];
    }
    
    NSString *countryName = [self.countryList objectAtIndex:indexPath.row];
    NSLog(@"%@", countryName);
    countryCell.lblCountryName.text = countryName;
    return countryCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *countryName = [self.countryList objectAtIndex:indexPath.row];
    self.txtFieldActive.text = countryName;
    [self fadeOutCountriesTableView];
}

- (void)moveCountriesListToActiveTextfield
{
    CGFloat newYPosition = self.txtFieldActive.frame.origin.y + 6;
    self.constraintTableViewYPosition.constant = newYPosition;
}

-(void)fadeInCountriesTableView
{
    if (self.tableViewCountries.alpha == 0)
    {
        [self.tableViewCountries setAlpha:0];
        [UITableView beginAnimations:NULL context:nil];
        [UITableView setAnimationDuration:0.5];
        [self.tableViewCountries setAlpha:1];
        [UITableView commitAnimations];
    }
}

-(void)fadeOutCountriesTableView
{
    if (self.tableViewCountries.alpha == 1)
    {
        [UITableView beginAnimations:NULL context:nil];
        [UITableView setAnimationDuration:0.5];
        [self.tableViewCountries setAlpha:0];
        [UITableView commitAnimations];
    }
}

- (IBAction)searchButtonPressed:(id)sender
{
    self.lblSearchResult.text = SEARCH_NOT_IMPLEMENTED;
}
@end
