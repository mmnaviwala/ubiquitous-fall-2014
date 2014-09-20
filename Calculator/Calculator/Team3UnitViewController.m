//
//  Team3UnitViewController.m
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3UnitViewController.h"
#import "Team3UnitConversionHelper.h"

@interface Team3UnitViewController ()
@property NSArray *measurementTypes;
@property NSArray *measurementUnitLength;
@property NSArray *measurementUnitMass;
@property NSArray *measurementUnitTime;
@property NSArray *measurementUnitTemperature;
@property NSArray *currentMeasurementUnit;
@property NSArray *measurmentIconNamesLight;
@property NSArray *measurmentIconNamesDark;
@property NSInteger currentConvertFromRowNum;
@property NSInteger currentConvertToRowNum;
@end

@implementation Team3UnitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize Data
    self.measurementTypes = @[@"Length", @"Mass", @"Time", @"Temperature"];
    self.measurementUnitLength = @[@"Kilometer", @"Meter", @"Centimeter"];
    self.measurementUnitMass = @[@" Metric Ton", @"Kilogram", @"Gram", @"Milligram"];
    self.measurementUnitTime = @[@"Days", @"Hour", @"Minutes"];
    self.measurementUnitTemperature = @[@"Celsius", @"Fahrenheit", @"Kelvin"];
    self.measurmentIconNamesLight = @[@"lengthIconLight", @"massIconLight", @"timeIconLight", @"temperatureIconLight"];
    self.measurmentIconNamesDark = @[@"lengthIconDark", @"massIconDark", @"timeIconDark", @"temperatureIconDark"];
    
    // Setting the deafult measurement unit
    self.currentMeasurementUnit = self.measurementUnitLength;
    
    // Connect data
    self.pickerMeasurementType.dataSource = self;
    self.pickerMeasurementType.delegate = self;
    
    self.pickerConvertFrom.dataSource = self;
    self.pickerConvertFrom.delegate = self;
    
    self.pickerConvertTo.dataSource = self;
    self.pickerConvertTo.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if([pickerView isEqual: self.pickerMeasurementType]){
        return 1;
    }
    if([pickerView isEqual: self.pickerConvertFrom] || [pickerView isEqual: self.pickerConvertTo]){
        return 1;
    }
    return 0;
}


// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView isEqual: self.pickerMeasurementType]){
        return self.measurementTypes.count;
    }
    if([pickerView isEqual: self.pickerConvertFrom] || [pickerView isEqual: self.pickerConvertTo]){
        return self.currentMeasurementUnit.count;
    }
    return 0;
}

// The data to return for the row and component (column) that's being passed in
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        tView.textAlignment = NSTextAlignmentCenter;
        // tView.textColor = [UIColor whiteColor];
        
        if([pickerView isEqual: self.pickerMeasurementType]){
            UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(1,2,20,20)];
            dot.image=[UIImage imageNamed:[self.measurmentIconNamesDark objectAtIndex:row]];
            [tView addSubview:dot];
        }
        if([pickerView isEqual: self.pickerConvertFrom] || [pickerView isEqual: self.pickerConvertTo]){
            tView.text = [self.currentMeasurementUnit objectAtIndex:row];
        }
        
        if([pickerView selectedRowInComponent:component] == row){
            tView.backgroundColor = [UIColor darkGrayColor];
            tView.textColor = [UIColor whiteColor];
            
            if([pickerView isEqual: self.pickerMeasurementType]){
                UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(1,2,20,20)];
                dot.image=[UIImage imageNamed:[self.measurmentIconNamesLight objectAtIndex:row]];
                [tView addSubview:dot];
            }
        }
        
    }
    
    return tView;
}


// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    [pickerView reloadComponent:component];
    
    if ([pickerView isEqual: self.pickerMeasurementType]) {
        switch (row) {
            case 0:
                self.currentMeasurementUnit = self.measurementUnitLength;
                break;
            case 1:
                self.currentMeasurementUnit = self.measurementUnitMass;
                break;
            case 2:
                self.currentMeasurementUnit = self.measurementUnitTime;
                break;
            case 3:
                self.currentMeasurementUnit = self.measurementUnitTemperature;
                break;
            default:
                break;
        }
        [self.pickerConvertFrom reloadAllComponents];
        [self.pickerConvertTo reloadAllComponents];
    }
    
    if([pickerView isEqual: self.pickerConvertFrom]){
        self.currentConvertFromRowNum = row;
    }
    if([pickerView isEqual: self.pickerConvertTo]){
        self.currentConvertToRowNum = row;
    }
    
    [self startConversion:([self.userInput.text doubleValue])];
    
}


- (IBAction)userInputChanged:(id)sender {
    [self startConversion:([self.userInput.text doubleValue])];
}

- (void) startConversion: (double)NumberToBeConverted{
    
    double ConvertedNumber = 0;
    NSString *finalNumberToDisplay;
    
#pragma mark Length
    if ([self.currentMeasurementUnit isEqual: self.measurementUnitLength]) {
        if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 0){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertKilometerToMeter:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertKilometerToCentimeter:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertMeterToKilometer:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 1){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertMeterToCentimeter:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertCentimeterToKilometer:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertCentimeterToMeter:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 2){
            ConvertedNumber =  NumberToBeConverted;
        }
    }
    
#pragma mark Mass
    if ([self.currentMeasurementUnit isEqual: self.measurementUnitMass]) {
        if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 0){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertMetricTonToKilogram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertMetricTonToGram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 3){
            ConvertedNumber = [Team3UnitConversionHelper convertMetricTonToMilligram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertKilogramToMetricTon:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 1){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertKilogramToGram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 3){
            ConvertedNumber = [Team3UnitConversionHelper convertKilogramToMilligram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertGramToMetricTon:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertGramToKiloGram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 2){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 3){
            ConvertedNumber = [Team3UnitConversionHelper convertGramToMilligram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 3 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertMilligramToMetricTon:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 3 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertMilligramToKilogram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 3 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertMilligramToGram:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 3 && self.currentConvertToRowNum == 3){
            ConvertedNumber =  NumberToBeConverted;
        }
    }
    
#pragma mark Time
    if ([self.currentMeasurementUnit isEqual: self.measurementUnitTime]) {
        if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 0){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertDaysToHours:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertDaysToMinutes:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertHoursToDays:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 1){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertHoursToMinutes:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertMinutesToDays:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertMinutesToHours:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 2){
            ConvertedNumber =  NumberToBeConverted;
        }
    }
    
#pragma mark Temperature
    if ([self.currentMeasurementUnit isEqual: self.measurementUnitTemperature]) {
        if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 0){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertCelsiusToFahrenheit:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 0 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertCelsiusToKelvin:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertFahrenheitToCelsius:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 1){
            ConvertedNumber =  NumberToBeConverted;
        }if(self.currentConvertFromRowNum == 1 && self.currentConvertToRowNum == 2){
            ConvertedNumber = [Team3UnitConversionHelper convertFahrenheitToKelvin:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 0){
            ConvertedNumber = [Team3UnitConversionHelper convertKelvinToCelsius:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 1){
            ConvertedNumber = [Team3UnitConversionHelper convertKelvinToFahrenheit:NumberToBeConverted];
        }if(self.currentConvertFromRowNum == 2 && self.currentConvertToRowNum == 2){
            ConvertedNumber =  NumberToBeConverted;
        }
    }
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.exponentSymbol = @"e";
    formatter.positiveFormat = @"0.#E+0";
    NSNumber *aDouble = [NSNumber numberWithDouble:ConvertedNumber];
    
    if ([aDouble stringValue].length < 6) {
        finalNumberToDisplay = [aDouble stringValue];
    }else{
        finalNumberToDisplay = [formatter stringFromNumber:aDouble];
    }
    
    self.answerLabel.text = [NSString stringWithFormat:@"%.01f %@ = %.06f %@", NumberToBeConverted, [self.currentMeasurementUnit objectAtIndex:self.currentConvertFromRowNum], ConvertedNumber, [self.currentMeasurementUnit objectAtIndex:self.currentConvertToRowNum]];
    
    self.convertedNumberDisplay.text = [NSString stringWithFormat:@"%@", finalNumberToDisplay];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
