//
//  DCXMLParser.h
//  DumbCharade
//
//  Created by Santa on 1/23/13.
//
//

#import <Foundation/Foundation.h>

@interface DCXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError * __autoreleasing *errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;
@end
