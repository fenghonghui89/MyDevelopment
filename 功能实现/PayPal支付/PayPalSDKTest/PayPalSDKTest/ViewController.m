//
//  ViewController.m
//  PaypalSDKTest
//
//  Created by 冯鸿辉 on 16/9/13.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "PayPalMobile.h"

@interface ViewController ()<PayPalPaymentDelegate,PayPalFuturePaymentDelegate,PayPalProfileSharingDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *environmentSegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *acceptCreditCardsSwitch;

@property(nonatomic,strong)PayPalConfiguration *payPalConfig;
@end

@implementation ViewController

#pragma mark - < vc lifecycle >
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self commonInitUI];
  [self setupPayPal];
}



#pragma mark - < method >

-(void)commonInitUI{
  self.environmentSegmentedControl.selectedSegmentIndex = 1;
  self.acceptCreditCardsSwitch.on = YES;
}

-(void)setupPayPal{

  NSLog(@"version:%@",[PayPalMobile libraryVersion]);
  
  [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                         PayPalEnvironmentSandbox : @"AThBu2AFb86vag14mTGSN17EysP0WtkHej8ni0OXU5y-qnccMY0bYObf7qTMOhL0Xh6vSy3W-XP29RnC"}];
  PayPalConfiguration *payPalConfig = [[PayPalConfiguration alloc] init];
  payPalConfig.acceptCreditCards = self.acceptCreditCardsSwitch.on;
  payPalConfig.merchantName = @"Awesome Shirts, Inc.";
  payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
  payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
  payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];//依据当前手机设置语言
  payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
  self.payPalConfig = payPalConfig;
  
  NSString *environment = [[self.environmentSegmentedControl titleForSegmentAtIndex:self.environmentSegmentedControl.selectedSegmentIndex] lowercaseString];
  [PayPalMobile preconnectWithEnvironment:environment];
}

-(NSString *)randomString{

  NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  
  // Get the characters into a C array for efficient shuffling
  NSUInteger numberOfCharacters = [alphabet length];
  unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
  [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
  
  // Perform a Fisher-Yates shuffle
  for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
    NSUInteger j = (arc4random_uniform(numberOfCharacters - i) + i);
    unichar c = characters[i];
    characters[i] = characters[j];
    characters[j] = c;
  }
  
  // Turn the result back into a string
  NSString *result = [NSString stringWithCharacters:characters length:numberOfCharacters];
  free(characters);
  return result;

}

#pragma mark - < action >
#pragma mark PayPal
- (IBAction)singlePaymentBtnTap:(id)sender {
  
  PayPalItem *item1 = [PayPalItem itemWithName:@"Ground Coffee 40 oz"
                                  withQuantity:1
                                     withPrice:[NSDecimalNumber decimalNumberWithString:@"7.5"]
                                  withCurrency:@"USD"
                                       withSku:@"Hip-00037"];
  PayPalItem *item2 = [PayPalItem itemWithName:@"Granola bars"
                                  withQuantity:5
                                     withPrice:[NSDecimalNumber decimalNumberWithString:@"2.00"]
                                  withCurrency:@"USD"
                                       withSku:@"Hip-00066"];
  NSArray *items = @[item1, item2];
  NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
  
  
  PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                             withShipping:[NSDecimalNumber decimalNumberWithString:@"1.30"]
                                                                                  withTax:[NSDecimalNumber decimalNumberWithString:@"1.20"]];
  
  
  PayPalPayment *payment = [[PayPalPayment alloc] init];
  payment.amount = [NSDecimalNumber decimalNumberWithString:@"20.00"];
  payment.currencyCode = @"USD";
  payment.shortDescription = @"Payment description";
  payment.invoiceNumber = [self randomString];
  payment.items = items;  // if not including multiple items, then leave payment.items as nil
  payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
  
  if (!payment.processable) {
    // This particular payment will always be processable. If, for
    // example, the amount was negative or the shortDescription was
    // empty, this payment wouldn't be processable, and you'd want
    // to handle that here.
  }
  
  PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                              configuration:self.payPalConfig
                                                                                                   delegate:self];
  [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (IBAction)authorizeFuturePaymentsBtnTap:(id)sender {
  
  PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
  [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}

- (IBAction)authorizeProfileShareingBtnTap:(id)sender {
  
  NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
  PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
  [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}

#pragma mark other
- (IBAction)environmentSegmentedControlDidChange:(UISegmentedControl *)sender {
  [PayPalMobile preconnectWithEnvironment:[[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] lowercaseString]];
}

- (IBAction)acceptCreditCardsSwitchDidChange:(UISwitch *)sender {
  self.payPalConfig.acceptCreditCards = sender.on;
}


#pragma mark - < delegate >
#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
  
  NSLog(@"PayPal Payment Success! %@",[completedPayment description]);

  // TODO: Send authorization to server
  //request
  NSString *postBody = @"theRegionCode=广东";
  NSData *postBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://dev.paypal.com/sample/payments/ExecutePayment.php?success=true"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:postBodyData];
  
  //session data task
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      NSHTTPURLResponse *httpUrlRespon = (NSHTTPURLResponse *)response;
      NSLog(@"header:%@",[httpUrlRespon allHeaderFields]);
      
      NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"content:%@",content);
    }else{
      NSLog(@"error:%@",[error localizedDescription]);
    }
  }];
  
  [task resume];

  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
  
  NSLog(@"PayPal Payment Canceled");

  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
  
  NSLog(@"PayPal Future Payment Authorization Success! %@",[futurePaymentAuthorization description]);

  // TODO: Send authorization to server
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
  
  NSLog(@"PayPal Future Payment Authorization Canceled");

  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark PayPalProfileSharingDelegate methods

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
  
  NSLog(@"PayPal Profile Sharing Authorization Success! %@",[profileSharingAuthorization description]);

  // TODO: Send authorization to server
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
  
  NSLog(@"PayPal Profile Sharing Authorization Canceled");

  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
