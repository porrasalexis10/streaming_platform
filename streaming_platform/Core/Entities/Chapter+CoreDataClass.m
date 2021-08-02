//
//  Chapter+CoreDataClass.m
//  
//
//  Created by Alexis Porras on 01/08/21.
//
//

#import "Chapter+CoreDataClass.h"

@implementation Chapter
- (void)processRow:(NSDictionary *)serverRow
{
    if (self.sync_status == 0)
        return;

    self.db_id = serverRow[@"imdbID"];
    
    self.movie_id = serverRow[@"seriesID"];
    self.title = serverRow[@"Title"];
    self.season = serverRow[@"Season"];
    self.episode = serverRow[@"Episode"];
    self.plot = serverRow[@"Plot"];
    self.runtime = serverRow[@"Runtime"];
    self.poster = serverRow[@"Poster"];
    
    self.sync_status = 1;
    self.enabled = 1;
}
@end
