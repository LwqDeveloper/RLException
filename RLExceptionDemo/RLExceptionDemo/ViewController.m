//
//  ViewController.m
//  RLException
//
//  Created by 李韦琼(Weiqiong Li)-顺丰科技 on 2018/9/13.
//  Copyright © 2018年 李韦琼(Weiqiong Li)-顺丰科技. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"RLExceptionDemo";
    [self initDatas];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** -[__NSDictionaryI objectAtIndexedSubscript:]: unrecognized selector sent to instance 0x600000468780 */
    NSDictionary *dict = self.datas[indexPath.section][@"contents"][indexPath.row];
    [self performSelector:NSSelectorFromString(dict[@"content"]) withObject:nil afterDelay:0.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datas[section][@"contents"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIde = @"cellIde";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    NSDictionary *dict = self.datas[indexPath.section][@"contents"][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.bounds.size.width -20, view.bounds.size.height)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = self.datas[section][@"title"];
    label.textColor = [UIColor darkGrayColor];
    [view addSubview:label];
    
    return view;
}

- (void)initDatas
{
    self.datas = [NSMutableArray array];
    NSArray *arrayContents = @[
                               @{@"title":@"array[3] 越界",@"content":@"array_beyoundBounds0"},
                               @{@"title":@"[array objectAtIndex:3] 越界",@"content":@"array_beyoundBounds1"},
                               @{@"title":@"[array addObject:@\"3\"]",@"content":@"array_addObject"},
                               @{@"title":@"array[@\"key\"]",@"content":@"array_objectForKeyedSubscript"},
                               @{@"title":@"[array objectForKey:@\"key\"]",@"content":@"array_objectForKey"}
                               ];
    [self.datas addObject:@{@"title":@"NSArray",@"contents":arrayContents}];
    
    NSArray *mulArrayContents = @[
                                  @{@"title":@"mulArray[3] 越界",@"content":@"mulArray_beyoundBounds0"},
                                  @{@"title":@"[mulArray objectAtIndex:3] 越界",@"content":@"mulArray_beyoundBounds1"},
                                  @{@"title":@"[mulArray removeObjectsInRange:3]",@"content":@"mulArray_removeObjectsInRange"},
                                  @{@"title":@"[mulArray addObject:nill]",@"content":@"mulArray_addObjectNil"},
                                  @{@"title":@"[mulArray insertObject:atIndex:]",@"content":@"mulArray_insertObject_atIndex"},
                                  @{@"title":@"mulArray[@\"key\"]",@"content":@"mulArray_objectForKeyedSubscript"},
                                  @{@"title":@"[mulArray objectForKey:@\"key\"]",@"content":@"mulArray_objectForKey"}
                                  ];
    [self.datas addObject:@{@"title":@"NSMultableArray",@"contents":mulArrayContents}];
    
    NSArray *dictContents = @[
                              @{@"title":@"dict initWithObjects_forKeys_count",@"content":@"dict_initWithObjects_forKeys_count0"},
                              @{@"title":@"NSDictionary initWithObjects_forKeys_count",@"content":@"dict_initWithObjects_forKeys_count1"},
                              ];
    [self.datas addObject:@{@"title":@"NSDictionary",@"contents":dictContents}];
    
    NSArray *mulDictContents = @[
                                 @{@"title":@"mulDict[nil]",@"content":@"mulDict_setObject_forKeyNil0"},
                                 @{@"title":@"[mulDict setObject_forKey]",@"content":@"mulDict_setObject_forKeyNil1"},
                                 @{@"title":@"[mulDict removeObject_forKey]]",@"content":@"mulDict_removeObject_forKey"},
                                 ];
    [self.datas addObject:@{@"title":@"NSDictionary",@"contents":mulDictContents}];
}

#pragma mark - NSArray
- (void)array_beyoundBounds0
{
    NSArray *array = @[@"0", @"1", @"2"];
    NSLog(@"%@",array[0]);
    NSLog(@"%@",array[1]);
    NSLog(@"%@",array[2]);
    NSLog(@"%@",array[3]);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)array_beyoundBounds1
{
    NSArray *array = @[@"0", @"1", @"2"];
    NSLog(@"%@",[array objectAtIndex:0]);
    NSLog(@"%@",[array objectAtIndex:1]);
    NSLog(@"%@",[array objectAtIndex:2]);
    NSLog(@"%@",[array objectAtIndex:3]);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)array_addObject
{
    NSArray *array = @[@"0",@"1",@"2"];
    NSMutableArray *mulArray = [[NSMutableArray arrayWithArray:array] copy];
    [mulArray addObject:@"3"];
    NSLog(@"%@",array);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)array_objectForKeyedSubscript
{
    NSArray *array = @[@[@"1",@"2"]];
    NSLog(@"%@",array[0][@"key"]);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)array_objectForKey
{
    NSArray *array = @[@[@"1"]];
    NSLog(@"%@",[array[0] objectForKey:@"1"]);
    NSLog(@"-----------------------------------------------------------------------");
}

#pragma mark - NSMultableArray
- (void)mulArray_beyoundBounds0
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"0", @"1", @"2"]];
    NSLog(@"%@",array[3]);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulArray_beyoundBounds1
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"0", @"1", @"2"]];
    NSLog(@"%@",[array objectAtIndex:3]);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulArray_removeObjectsInRange
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"0", @"1", @"2"]];
    [array removeObjectAtIndex:3];
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulArray_addObjectNil
{
    NSObject *object = nil;
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"0"]];
    [array addObject:object];
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulArray_insertObject_atIndex
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"0"]];
    [array insertObject:@"1" atIndex:2];
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulArray_objectForKeyedSubscript
{
    NSMutableArray *mulArray = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
    NSArray *array = [NSArray arrayWithObject:mulArray];
    NSLog(@"%@",array[0][@"key"]);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulArray_objectForKey
{
    NSMutableArray *mulArray = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
    NSArray *array = [NSArray arrayWithObject:mulArray];
    NSLog(@"%@",[array[0] objectForKey:@"1"]);
    NSLog(@"-----------------------------------------------------------------------");
}

#pragma mark - NSDictionary
- (void)dict_initWithObjects_forKeys_count0
{
    NSObject *object = nil;
    NSDictionary *dict = @{@"0":@"1",@"2":object};
    NSLog(@"%@",dict);
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)dict_initWithObjects_forKeys_count1
{
    NSObject *object = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:object, @"1", nil];
    NSLog(@"%@",dict);
    NSLog(@"-----------------------------------------------------------------------");
}

#pragma mark - NSMultableDictionary
- (void)mulDict_setObject_forKeyNil0
{
    NSString *object = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"1"}];
    dict[object] = @"2";
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulDict_setObject_forKeyNil1
{
    NSString *object = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"1"}];
    [dict setObject:@"2" forKey:object];
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)mulDict_removeObject_forKey
{
    NSString *object = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"1"}];
    [dict removeObjectForKey:object];
    NSLog(@"-----------------------------------------------------------------------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
