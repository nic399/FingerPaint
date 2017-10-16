//
//  ViewController.m
//  FingerPaint
//
//  Created by Nicholas Fung on 2017-10-13.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ViewController.h"
#import "CanvasView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CanvasView *canvasView;
@property (nonatomic) UIColor *color;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *colorPicker = [[UIBarButtonItem alloc] initWithTitle:@"Color" style:UIBarButtonItemStylePlain target:self action:@selector(showColorPicker:)];
    self.navigationItem.rightBarButtonItem = colorPicker;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //UIView *canvas = [[CanvasView alloc] init];
    
    
}

-(IBAction)showColorPicker:(id)sender {
    FCColorPickerViewController *colorPickerViewController = [FCColorPickerViewController colorPickerWithColor:[UIColor whiteColor] delegate:self];
    [self.navigationController pushViewController:colorPickerViewController animated:true];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    
}

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    [self.canvasView setLineColor:color];
    NSLog(@"color description is: %@", color.description);
}

@end
