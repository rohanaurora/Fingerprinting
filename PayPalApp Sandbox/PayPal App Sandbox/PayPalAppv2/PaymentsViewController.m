//
//  PaymentsViewController.m
//  PayPalAppv2
//
//  Created by Rohan Aurora on 7/11/14.
//  Copyright (c) 2014 eBay Inc. All rights reserved.
//

#import "PaymentsViewController.h"
#define kPayPalEnvironment PayPalEnvironmentSandbox

@interface PaymentsViewController ()
@end

@implementation PaymentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setting up payPalConfig
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    self.payPalConfig.acceptCreditCards = YES;
    self.payPalConfig.languageOrLocale = @"en";
    self.payPalConfig.merchantName = @"Nike, Inc.";
    self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    self.payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    NSLog(@"Inline Checkout Demo in Sandbox Environment");
}

// Connecting to the PayPal servers

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [PayPalMobile preconnectWithEnvironment:self.environment];
}


#pragma mark - Receive Single Payment

- (IBAction)singlePayment {
    
    // Mock data
    PayPalItem *firstItem = [PayPalItem itemWithName:@"Nike Flyknit Shoes"
                                    withQuantity:1
                                    withPrice:[NSDecimalNumber decimalNumberWithString:@"49.99"]
                                    withCurrency:@"USD"
                                    withSku:@"1234"];
    
    NSArray *items = @[firstItem];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"5.99"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"2.50"];
    
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];

    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.paymentDetails = paymentDetails;
    payment.amount = total;
    

    payment.currencyCode = @"USD";
    payment.shortDescription = @"Nike Flyknit Running Shoes";
    payment.items = items;
    
    
    if (!payment.processable) {
    }
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

// Payment Success
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    
    NSLog(@"PayPal Single Payment Success!");
    
    [self sendCompletedPaymentToServer:completedPayment];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// Payment Cancellation
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    
    NSLog(@"PayPal Single Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);

}


@end
