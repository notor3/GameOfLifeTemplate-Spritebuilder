//
//  Creature.m
//  GameOfLife
//
//  Created by Bartłomiej Pater on 22.10.2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        _isAlive = NO;
    }
    
    return self;
}

-(void)setIsAlive:(BOOL)isAlive {
    _isAlive = isAlive;
    self.visible = _isAlive;
}

@end
