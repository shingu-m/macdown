//
//  NSDocumentController+Document.m
//  MacDown
//
//  Created by Tzu-ping Chung on 25/1.
//  Copyright (c) 2015 Tzu-ping Chung . All rights reserved.
//

#import "NSDocumentController+Document.h"

@implementation NSDocumentController (Document)

- (__kindof NSDocument *)createNewEmptyDocumentForURL:(NSURL *)url
        display:(BOOL)display error:(NSError * __autoreleasing *)error
{
    [[NSFileManager defaultManager] createFileAtPath:[url path]
                                            contents:[NSData data]
                                          attributes:nil];

    NSString *type = [self typeForContentsOfURL:url error:error];
    if (!type)
        return nil;

    NSDocument *doc = [self makeDocumentWithContentsOfURL:url
                                                   ofType:type
                                                    error:error];
    if (!doc)
        return nil;

    [self addDocument:doc];
    [self noteNewRecentDocument:doc];
    [doc makeWindowControllers];
    if (display)
        [doc showWindows];
    return doc;
}

@end
