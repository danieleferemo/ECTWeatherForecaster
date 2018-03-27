//
//  ECTWeeklyForecastCell.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTWeeklyForecastCell.h"

#import "ECTWeather.h"

#import "ECTUtilityMethods.h"

@interface ECTWeeklyForecastCell ()

@property (nonatomic, strong) ECTUtilityMethods *utilityMethods;

@end

@implementation ECTWeeklyForecastCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _temperatureLbl.text = @"";
    _descLbl.text = @"";
    _chanceOfRainLbl.text = @"";
    _dateDayLbl.text = @"";
    _dateNumbLbl.text = @"";
    _temperatureLbl.textColor = [UIColor blackColor];
}

#pragma mark - private methods

-(void) configureSubviews
{
    [self layoutSubviews];
    
    _utilityMethods = [[ECTUtilityMethods alloc] init];
    CGFloat screenWidth = [_utilityMethods getScreenWidth];
    
    CGFloat cellHeight = screenWidth * 0.4;
    
    NSNumber *thirtyPercH = [NSNumber numberWithFloat:cellHeight * 0.3];
    NSNumber *fiftyPercH = [NSNumber numberWithFloat:cellHeight * 0.5];
    NSNumber *fortyPercH = [NSNumber numberWithFloat:cellHeight * 0.4];
    NSNumber *fifteenPercH = [NSNumber numberWithFloat:cellHeight * 0.15];
    
    NSNumber *twentyPercSW = [NSNumber numberWithFloat:screenWidth * 0.2];
    NSNumber *fifteenPercSW = [NSNumber numberWithFloat:screenWidth * 0.15];
    
    NSNumber *middleBorderThickness = [NSNumber numberWithInteger:1.0];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    [leftView addSubview:self.temperatureLbl];
    [leftView addSubview:self.descLbl];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *innerRightView = [[UIView alloc] init];
    innerRightView.translatesAutoresizingMaskIntoConstraints = NO;
//    [innerRightView addSubview:self.rainDropIconIV];
    [innerRightView addSubview:self.chanceOfRainLbl];
    
    [rightView addSubview:innerRightView];
    [rightView addSubview:self.dateNumbLbl];
    [rightView addSubview:self.dateDayLbl];
    
    UIView *middleBorder = [[UIView alloc] init];
    middleBorder.backgroundColor = [UIColor lightGrayColor];
    middleBorder.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:middleBorder];
    [self.contentView addSubview:leftView];
    [self.contentView addSubview:rightView];
    
    NSDictionary *views = @{
                            @"temperatureLbl": self.temperatureLbl,
                            @"descLbl": self.descLbl,
                            @"rainDropIconIV": self.rainDropIconIV,
                            @"chanceOfRainLbl": self.chanceOfRainLbl,
                            @"dateNumbLbl": self.dateNumbLbl,
                            @"dateDayLbl":self.dateDayLbl,
                            @"rightView":rightView,
                            @"leftView":leftView,
                            @"innerRightView":innerRightView,
                            @"middleBorder":middleBorder
                            };
    
    NSDictionary *metrics = @{
                              @"fiftyPercH":fiftyPercH,
                              @"thirtyPercH":thirtyPercH,
                              @"twentyPercSW":twentyPercSW,
                              @"fifteenPercSW":fifteenPercSW,
                              @"thirtyPercH":thirtyPercH,
                              @"fortyPercH":fortyPercH,
                              @"middleBorderThickness":middleBorderThickness,
                              @"fifteenPercH":fifteenPercH
                              };
    
    [leftView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[temperatureLbl]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [leftView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descLbl]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    [leftView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[temperatureLbl][descLbl(fortyPercH)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    
    
    [innerRightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[chanceOfRainLbl]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
//    [innerRightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rainDropIconIV]|"
//                                                                      options:0
//                                                                      metrics:metrics
//                                                                        views:views]];
    [innerRightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[chanceOfRainLbl]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [rightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[innerRightView]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    [rightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dateNumbLbl]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    [rightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dateDayLbl]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    [rightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[innerRightView(>=0)][dateNumbLbl(fiftyPercH)][dateDayLbl(thirtyPercH)]|"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftView]-4-[middleBorder(middleBorderThickness)]-4-[rightView(twentyPercSW)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftView]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightView]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-fifteenPercH-[middleBorder]-fifteenPercH-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
}

#pragma mark - Getters

-(UIImageView *) rainDropIconIV
{
    if(!_rainDropIconIV)
    {
        _rainDropIconIV =  [[UIImageView alloc] init];
        _rainDropIconIV.translatesAutoresizingMaskIntoConstraints = NO;
        _rainDropIconIV.backgroundColor = [UIColor redColor];
        
        UIImage *img = [UIImage imageNamed:@"RainDrop"];
        [_rainDropIconIV setImage:img];
    }
    return _rainDropIconIV;
}

-(UILabel *)descLbl
{
    if(!_descLbl)
    {
        _descLbl = [self newLabel];
        _descLbl.backgroundColor = [UIColor clearColor];
        _descLbl.textAlignment = NSTextAlignmentCenter;
        _descLbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        _descLbl.textColor = [UIColor darkGrayColor];
    }
    return _descLbl;
}

-(UILabel *)temperatureLbl
{
    if(!_temperatureLbl)
    {
        _temperatureLbl = [self newLabel];
        _temperatureLbl.backgroundColor = [UIColor clearColor];
        _temperatureLbl.textAlignment = NSTextAlignmentCenter;
        _temperatureLbl.textColor = [UIColor blackColor];
        _temperatureLbl.font = [UIFont systemFontOfSize:38 weight:UIFontWeightSemibold];
    }
    return _temperatureLbl;
}

-(UILabel *) chanceOfRainLbl
{
    if(!_chanceOfRainLbl)
    {
        _chanceOfRainLbl = [self newLabel];
        _chanceOfRainLbl.backgroundColor = [UIColor clearColor];
        _chanceOfRainLbl.textAlignment = NSTextAlignmentCenter;
        _chanceOfRainLbl.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        _chanceOfRainLbl.textColor = [UIColor blackColor];
        
    }
    return _chanceOfRainLbl;
}

-(UILabel *) dateNumbLbl
{
    if(!_dateNumbLbl)
    {
        _dateNumbLbl = [self newLabel];
        _dateNumbLbl.backgroundColor = [UIColor clearColor];
        _dateNumbLbl.textAlignment = NSTextAlignmentCenter;
//        _dateNumbLbl.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        _dateNumbLbl.textColor = [UIColor blackColor];
    }
    return _dateNumbLbl;
}

-(UILabel *) dateDayLbl
{
    if(!_dateDayLbl)
    {
        _dateDayLbl = [self newLabel];
        _dateDayLbl.backgroundColor = [UIColor clearColor];
        _dateDayLbl.textAlignment = NSTextAlignmentCenter;
//        _dateDayLbl.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
        _dateDayLbl.textColor = [UIColor grayColor];
    }
    return _dateDayLbl;
}

-(UILabel *)newLabel
{
    UILabel *lbl = [UILabel new];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.userInteractionEnabled = NO;
    lbl.numberOfLines = 0;
    
    return lbl;
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self configureSubviews];
    }
    return self;
}

@end
