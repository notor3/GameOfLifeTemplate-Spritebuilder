//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Grid.h"

@interface MainScene : CCNode

@property Grid* grid;
@property CCLabelTTF *generationLabel;
@property CCLabelTTF *populationLabel;

- (void)play;
- (void)pause;

@end
