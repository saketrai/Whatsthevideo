//
//  DCVideo.h
//  DumbCharade
//
//  Created by Santa on 1/23/13.
//
//

#import <Foundation/Foundation.h>

@interface DCVideo : NSObject
{
    NSString    *m_pVideoID;
    NSString    *m_pVideoURL;
    NSString    *m_pVideoDuration;
    NSString    *m_pVideoTitle;
    NSString    *m_pOption1;
    NSString    *m_pOption2;
    NSString    *m_pOption3;
    NSString    *m_pOption4;
    NSString    *m_pAns;
}

@property(strong, nonatomic)  NSString    *m_pVideoID;
@property(strong, nonatomic)  NSString    *m_pVideoURL;
@property(strong, nonatomic)  NSString    *m_pVideoDuration;
@property(strong, nonatomic)  NSString    *m_pVideoTitle;
@property(strong, nonatomic)  NSString    *m_pOption1;
@property(strong, nonatomic)  NSString    *m_pOption2;
@property(strong, nonatomic)  NSString    *m_pOption3;
@property(strong, nonatomic)  NSString    *m_pOption4;
@property(strong, nonatomic)  NSString    *m_pAns;

@end
