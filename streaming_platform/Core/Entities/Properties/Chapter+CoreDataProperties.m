//
//  Chapter+CoreDataProperties.m
//  
//
//  Created by Alexis Porras on 01/08/21.
//
//

#import "Chapter+CoreDataProperties.h"

@implementation Chapter (CoreDataProperties)

+ (NSFetchRequest<Chapter *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Chapter"];
}

@dynamic db_id;
@dynamic enabled;
@dynamic episode;
@dynamic movie_id;
@dynamic plot;
@dynamic runtime;
@dynamic season;
@dynamic sync_status;
@dynamic title;
@dynamic poster;

@end
