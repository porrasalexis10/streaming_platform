//
//  Movie+CoreDataClass.m
//  
//
//  Created by Alexis Porras on 01/08/21.
//
//

#import "Movie+CoreDataClass.h"

@implementation Movie
- (void)processRow:(NSDictionary *)serverRow
{
    if (self.sync_status == 0)
        return;

    self.db_id = serverRow[@"imdbID"];
    
    self.title = serverRow[@"Title"];
    self.year = serverRow[@"Year"];
    self.rated = serverRow[@"Rated"];
    self.released = serverRow[@"Released"];
    self.genre = serverRow[@"Genre"];
    self.writer = serverRow[@"Writer"];
    self.actors = serverRow[@"Actors"];
    self.plot = serverRow[@"Plot"];
    self.type = serverRow[@"Type"];
    self.poster = serverRow[@"Poster"];
    
    self.raiting = [NSDecimalNumber decimalNumberWithString:serverRow[@"imdbRating"]];
    self.votes = [NSDecimalNumber decimalNumberWithString:serverRow[@"imdbVotes"]];
    
    self.sync_status = 1;
    self.enabled = 1;
}
@end
