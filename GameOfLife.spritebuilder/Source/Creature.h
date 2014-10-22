//
//  Creature.h
//  GameOfLife
//
//  Created by Bartłomiej Pater on 22.10.2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

@property(nonatomic, assign) BOOL isAlive;
@property(nonatomic, assign) NSInteger livingNeighbors;

-(id)initCreature;

@end
