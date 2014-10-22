//
//  Grid.m
//  GameOfLife
//
//  Created by Bartłomiej Pater on 22.10.2014.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid

	NSMutableArray *_gridArray;
	float _cellWidth;
	float _cellHeight;

-(void)onEnter {
	[super onEnter];
	[self setupGrid];
	self.userInteractionEnabled = YES;
}

- (void)setupGrid {
	_cellWidth = self.contentSize.width / GRID_COLUMNS;
	_cellHeight = self.contentSize.height / GRID_ROWS;

	float x = 0;
	float y = 0;

	_gridArray = [NSMutableArray array];

	for (u_int i = 0; i < GRID_ROWS; ++i) {
		_gridArray[i] = [NSMutableArray array];
		x = 0;
		for (u_int j = 0; j < GRID_COLUMNS; ++j) {
			Creature *creature = [[Creature alloc] initCreature];
			creature.anchorPoint = ccp(0, 0);
			creature.position = ccp(x, y);
			[self addChild:creature];
			_gridArray[i][j] = creature;
			x += _cellWidth;
		}
		y += _cellHeight;
	}
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint touchLocation = [touch locationInNode:self];
	Creature *creature = [self creatureForTouchLocation:touchLocation];
	creature.isAlive = !creature.isAlive;
}

- (Creature *)creatureForTouchLocation:(CGPoint)point {
	u_int column = (u_int) (point.x / _cellWidth);
	u_int row = (u_int) (point.y / _cellHeight);
	return _gridArray[row][column];
}

@end
