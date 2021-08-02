//
//  Movie+CoreDataProperties.m
//  
//
//  Created by Alexis Porras on 01/08/21.
//
//

#import "Movie+CoreDataProperties.h"

@implementation Movie (CoreDataProperties)

+ (NSFetchRequest<Movie *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
}

@dynamic actors;
@dynamic db_id;
@dynamic enabled;
@dynamic genre;
@dynamic plot;
@dynamic poster;
@dynamic rated;
@dynamic released;
@dynamic sync_status;
@dynamic title;
@dynamic type;
@dynamic writer;
@dynamic year;
@dynamic raiting;
@dynamic votes;
@dynamic is_favorite;

@end
