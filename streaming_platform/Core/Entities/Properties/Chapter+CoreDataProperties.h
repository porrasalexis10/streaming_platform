//
//  Chapter+CoreDataProperties.h
//  
//
//  Created by Alexis Porras on 01/08/21.
//
//

#import "Chapter+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Chapter (CoreDataProperties)

+ (NSFetchRequest<Chapter *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *db_id;
@property (nonatomic) BOOL enabled;
@property (nullable, nonatomic, copy) NSString *episode;
@property (nullable, nonatomic, copy) NSString *movie_id;
@property (nullable, nonatomic, copy) NSString *plot;
@property (nullable, nonatomic, copy) NSString *runtime;
@property (nullable, nonatomic, copy) NSString *season;
@property (nonatomic) int64_t sync_status;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *poster;

@end

NS_ASSUME_NONNULL_END
