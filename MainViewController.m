//
//  MainViewController.m
//  PostCard
//
//  Created by qianfeng on 13-11-19.
//  Copyright (c) 2013年 miao. All rights reserved.
//

#import "MainViewController.h"
#import "Mybutton.h"
#import "CamerViewController.h"
#import <QuartzCore/QuartzCore.h>

#define PATH @"/Users/1000phone/Desktop/PostCard/helper.plist"


@interface MainViewController () {
    UIScrollView *_scrollView;
    CamerViewController *_camerView;
    UIView *_blackView;
    UIView *_greatView;
    UIView *_tabBarView;
    
    //设置界面
    UIView *_setView;
    
    //设置界面的tableView
    UITableView *_setTableView;
}

@end

@implementation MainViewController {
    NSMutableArray *_dataArray;
    NSArray *_helpArray;
}

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
    
    _helpArray = [[NSArray alloc] initWithContentsOfFile:PATH];
    

    
    _dataArray = [[NSMutableArray alloc] init];
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:@"服务说明",@"明星片助手", nil];
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:@"推荐给好友",@"评分/检查更新",@"联系我们", nil];
    NSMutableArray *array3 = [[NSMutableArray alloc] initWithObjects:@"关于", nil];
    [_dataArray addObject:array1];
    [_dataArray addObject:array2];
    [_dataArray addObject:array3];
    //创建设置界面
    [self createSetView];
    
    _camerView=[[CamerViewController alloc]init];
    _blackView=[[UIView alloc]initWithFrame:CGRectMake(0, 35, 320, 380)];
    _blackView.backgroundColor=[UIColor blackColor];
    _blackView.alpha=0.5;
    [self.view addSubview:_blackView];
    [self createGreateView];
    [self createUI];
}

- (void)createSetView
{
    _setView = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 405)];
    [self.view addSubview:_setView];
    
    //红蓝条
    UIImage *tabHeadImage = [UIImage imageNamed:@"bg_setting@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 320, 22)];
    imageView.image = tabHeadImage;
    [_setView addSubview:imageView];
    
    _setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 9, 320, 340) style:UITableViewStylePlain];
//    _setTableView.backgroundView = nil;
//    _setTableView.alpha = 0.8;
    _setTableView.delegate = self;
    _setTableView.dataSource = self;
    [_setView addSubview:_setTableView];
    
    //返回按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(-10, 349, 340, 405-349);
    [button setBackgroundImage:[UIImage imageNamed:@"cell_mid@2x.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"cell_mid@2x.png"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_setView addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160-20, 10, 100, 30)];
    label.text = @"收起";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = [UIColor clearColor];
    [button addSubview:label];

}

- (void)cancel
{
    [UIView animateWithDuration:0.5 animations:^{
        _setView.Frame = CGRectMake(0, 480, 320, 405);
    } completion:^(BOOL finished) {
        [self.view sendSubviewToBack:_setView];
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 2;
    } else if(section == 1) {
        return 3;
    } else {
        return 1;
    } 
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"设置";
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 35;
    } else {
        return 20;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        [view addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"bg_mode1@2x.png"];
        
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        [view addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"bg_mode1@2x.png"];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hello"];
    cell.textLabel.text = [(NSMutableArray *)[_dataArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor = [UIColor darkGrayColor];

    
    if(indexPath.section !=2 || indexPath.row !=2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(indexPath.row == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 20)];
        label.text = @"邮件或微信";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
    }
    
    if(indexPath.section == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 20)];
        label.text = @"版本v1.0.9";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)createGreateView{
    _greatView=[[UIView alloc]initWithFrame:CGRectMake(70, 530, 180, 100)];
    _greatView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_greatView];

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, 180, 50);
    [btn setImage:[UIImage imageNamed:@"btn_normalcard_tapped@2x"] forState:UIControlStateNormal];
    btn.tag=7;
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 0, 100, 50)];
    nameLabel.text =@"DIY明信片";
    nameLabel.font =[UIFont boldSystemFontOfSize:15];
    nameLabel.backgroundColor =[UIColor clearColor];
    [btn addSubview:nameLabel];
//  btn.titleLabel.textAlignment=NSTextAlignmentRight;
    [_greatView addSubview:btn];
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame =CGRectMake(0, 50, 180, 50);
    [btn1 setImage:[UIImage imageNamed:@"btn_drawcard_tapped@2x"] forState:UIControlStateNormal];
    UILabel *nameLabel2=[[UILabel alloc]initWithFrame:CGRectMake(70, 0, 100, 50)];
    nameLabel2.text =@"海贼系列";
    nameLabel2.font =[UIFont boldSystemFontOfSize:15];
    nameLabel2.backgroundColor =[UIColor clearColor];
    [btn1 addSubview:nameLabel2];

    btn1.tag=8;
    [_greatView addSubview:btn1];
}
- (void)createUI
{
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    //背景图片
    UIImage *image = [UIImage imageNamed:@"bg_home@2x.jpg"];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 24, 320, 460-24)];
    bgImage.image = image;
    [self.view addSubview:bgImage];

    //自定义导航栏
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -35, 320, 50)];
    UIImage *navImage = [UIImage imageNamed:@"navbar@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
    imageView.image = navImage;
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 200, 20)];
    label2.text =@"随手明信片";
    [view addSubview:label2];
    [view addSubview:imageView];
    [self.view addSubview:view];
    
    
    
    //自定义tabbar
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 460-49, 320, 49)];
    [self.view addSubview:_tabBarView];
    
    //二维码按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 70, 49);
    [btn1 setImage:[UIImage imageNamed:@"tab_qr@2x.png"] forState:UIControlStateNormal];
    btn1.tag=4;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tabBarView addSubview:btn1];
    
    
    
    //中间按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(70, -3, 320-140, 52);
    [btn2 setImage:[UIImage imageNamed:@"tab_add@2x.png"] forState:UIControlStateNormal];
    btn2.tag=5;

    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tabBarView addSubview:btn2];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(135, 13, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"寄一张明信片";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.adjustsFontSizeToFitWidth = YES;
    [_tabBarView addSubview:label];

    
    //设置按钮
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(320-70, 0, 70, 49);
    [btn3 setImage:[UIImage imageNamed:@"tab_setting@2x.png"] forState:UIControlStateNormal];
    btn3.tag=6;

    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tabBarView addSubview:btn3];
    
    //分割线
    UIImage *fenge = [UIImage imageNamed:@"bg_line@2x.png"];
    UIImageView *fg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 350, 3.5)];
    fg.image = fenge;
    [self.view addSubview:fg];
    
    
    //UIScroller
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, 320, 480-49-118+10)];
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor =[UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(320*2, 310);
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(-80, 10, 80, 100)];
    label1.text=@"老缪";
    label1.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:label1];
    
    
    for(int i=0; i<2; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 285)];
        view.backgroundColor =[UIColor clearColor];
        [_scrollView addSubview:view];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(70, 45, 180, 258)];
        imageview.userInteractionEnabled=YES;
        imageview.image =image;
        [imageview.layer setShadowOpacity:0.9];
        [view addSubview:imageview];
        
        for (int j=0; j<4; j++) {
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(270, 100+45*j, 34, 45);
            btn.tag=j;
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_%d.png",j+1]]forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        
        Mybutton *mapBtn=[Mybutton buttonWithType:UIButtonTypeCustom];
        mapBtn.frame =CGRectMake(60, 0, 25, 25);
        [mapBtn setBackgroundImage:[UIImage imageNamed:@"icon_location@2x"] forState:UIControlStateNormal];
        [mapBtn setTitle:[NSString stringWithFormat:@"周口"] forState:UIControlStateNormal];
        mapBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
        //mapBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        mapBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        [view addSubview:mapBtn];
        Mybutton *messageBtn=[Mybutton buttonWithType:UIButtonTypeCustom];
        messageBtn.frame =CGRectMake(150, 0, 25,25);
        [messageBtn setTitle:[NSString stringWithFormat:@"10秒的录音"] forState:UIControlStateNormal];
        messageBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
        //mapBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        messageBtn.titleLabel.font=[UIFont systemFontOfSize:10];

        [messageBtn setBackgroundImage:[UIImage imageNamed:@"icon_talk@2x"] forState:UIControlStateNormal];
        [view addSubview:messageBtn];

    }
    
    
    
}
-(void)btnClick:(UIButton *)btn{
    if (btn.tag==0) {
        //购物车
    }else if(btn.tag==1){
        //下载本地
    }else if(btn.tag==2){
        //分享
    }else if(btn.tag==3){
        //删除
    }else if(btn.tag==4){
        //扫描二维码
        [self.navigationController pushViewController:_camerView animated:YES];
    }else if(btn.tag==5){
        //制作明信片
        static int i=0;
        if (i%2==0) {
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 1.0;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionFade;
            animation.subtype = kCATransitionFromRight;
            
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            [UIView animateWithDuration:0.3 animations:^{
                _greatView.frame=CGRectMake(70, 310, 180, 100);
            }];
        
            [self.view bringSubviewToFront:_blackView];
            [self.view bringSubviewToFront:_greatView];
            [self.view bringSubviewToFront:_tabBarView];
           
            i++;
            //弹出列表；
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                _greatView.frame=CGRectMake(70, 530, 180, 100);

            } completion:^(BOOL finished) {
                [self.view sendSubviewToBack:_blackView];
                [self.view sendSubviewToBack:_greatView];
            }];
            i++;
        }
    }else if(btn.tag==6){
        [UIView animateWithDuration:0.5 animations:^{
            _setView.frame = CGRectMake(0, 59, 320, 405);
            [self.view bringSubviewToFront:_setView];
        }];
        
    }else if(btn.tag==7){
        //自制明信片
    }else if(btn.tag==8){
        //系统提供
    }else{
        NSLog(@"瞎点什么呢");
    }
}
- (void)buttonClick
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
