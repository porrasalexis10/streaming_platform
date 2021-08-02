//
//  Movie+CoreDataProperties.h
//  
//
//  Created by Alexis Porras on 01/08/21.
//
//

#import "Movie+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Movie (CoreDataProperties)

+ (NSFetchRequest<Movie *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *actors;
@property (nullable, nonatomic, copy) NSString *db_id;
@property (nonatomic) BOOL enabled;
@property (nullable, nonatomic, copy) NSString *genre;
@property (nullable, nonatomic, copy) NSString *plot;
@property (nullable, nonatomic, copy) NSString *poster;
@property (nullable, nonatomic, copy) NSString *rated;
@property (nullable, nonatomic, copy) NSString *released;
@property (nonatomic) int64_t sync_status;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *writer;
@property (nullable, nonatomic, copy) NSString *year;
@property (nullable, nonatomic, copy) NSDecimalNumber *raiting;
@property (nullable, nonatomic, copy) NSDecimalNumber *votes;
@property (nonatomic) BOOL is_favorite;

@end

NS_ASSUME_NONNULL_END
