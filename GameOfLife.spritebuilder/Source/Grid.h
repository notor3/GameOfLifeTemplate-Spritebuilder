//
//  Grid.h
//  GameOfLife
//
//  Created by Bartłomiej Pater on 22.10.2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property(nonatomic,assign) int totalAlive;
@property(nonatomic,assign) int generation;

-(void)evolveStep;
- (void)countNeighbors;
- (void)updateCreatures;

@end
