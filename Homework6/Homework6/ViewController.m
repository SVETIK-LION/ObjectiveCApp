#import "ViewController.h"
#import "UserDataClass.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic) NSUserDefaults *userDefaults;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.userDefaults setObject:@"Svetlana" forKey:@"FirstName"];
    [self.userDefaults setObject:@"Lvovskaya" forKey:@"LastName"];
    [self.userDefaults setInteger:14383414 forKey:@"ID"];
    [self.userDefaults setDouble:1.62 forKey:@"Height"];
    [self.userDefaults setFloat:50.5 forKey:@"Weight"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *myFirstName = [self.userDefaults stringForKey:@"FirstName"];
    NSString *myLastName = [self.userDefaults stringForKey:@"LastName"];
    NSInteger myID = [self.userDefaults integerForKey:@"ID"];
    double myHeight = [self.userDefaults doubleForKey:@"Height"];
    float myWeight = [self.userDefaults floatForKey:@"Weight"];
    
    NSLog(@"User: %@ %@.\nID: %ld.\nHeight: %f m.\nWeight: %f kg.", myFirstName, myLastName, (long)myID, myHeight, myWeight);
    
    UserDataClass *userData = [[UserDataClass alloc] initWithHairColor: UIColor.blackColor];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData requiringSecureCoding:NO error:NULL];
    [self.userDefaults setObject:data forKey:@"userHairColor"];
    NSData *userHairColorData = [self.userDefaults objectForKey:@"userHairColor"];
    UserDataClass *user = [NSKeyedUnarchiver unarchivedObjectOfClass:UserDataClass.class fromData:userHairColorData error:NULL];
    // не получается декодировать объект, объекту присваивается null
    
    NSLog(@"%@", user.hairColor);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSURL *url = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *newFolderUrl = [url URLByAppendingPathComponent:@"User-Object"];
    NSURL *pathOfData = [newFolderUrl URLByAppendingPathComponent:@"User-Data.txt"];

    NSData *textForFile = [@"Test text" dataUsingEncoding:kCFStringEncodingUTF8];

    if ([fileManager createDirectoryAtURL:newFolderUrl withIntermediateDirectories:YES attributes:nil error:nil]){
        [fileManager createFileAtPath:pathOfData.path contents:data attributes:nil];
    }

    if ([fileManager fileExistsAtPath:pathOfData.path]){
        NSData *newData = [fileManager contentsAtPath:pathOfData.path];
        UserDataClass *userData = [NSKeyedUnarchiver unarchivedObjectOfClass:[UserDataClass class] fromData:newData error:NULL];
//        та же проблема с декодированием
        NSLog(@"UserHairColor is %@", userData.hairColor);
//        [fileManager removeItemAtURL:pathOfData.path error:nil];
        // приложение крашится
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    NSData *plistData = [fileManager contentsAtPath:plistPath];
    NSDictionary *plistDict = [NSPropertyListSerialization propertyListWithData:plistData
                                                                        options:NSPropertyListImmutable
                                                                         format:nil
                                                                          error:nil];
    NSLog(@"%@", plistDict);
    
    NSString *text = @"some text";
    unichar a;
    int index = 9;
    
    @try {
        a = [text characterAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    } @finally {
        NSLog(@"executed");
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"did appear");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"will disappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"did disappear");
}

- (void)resetUserDefaults {
    NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [uDefaults dictionaryRepresentation];
    for (id key in dictionary) {
        [uDefaults removeObjectForKey:key];
    }
    [uDefaults synchronize];
}


@end
