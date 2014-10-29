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

- (void)evolveStep {
	[self countNeighbors];
	[self updateCreatures];
	_generation++;
}

- (void)countNeighbors {
	for (u_int i = 0; i < [_gridArray count]; ++i) {
		for (u_int j = 0; j < [_gridArray count]; ++j) {
			Creature *current = _gridArray[i][j];
			current.livingNeighbors = 0;
			for (int y = (i-1); y <= (i+1) ; ++y) {
				for (int x = (j-1); x <= (j+1) ; ++x) {
					BOOL isIndexValid = [self isIndexValidForX:x andY:y];
					if ((y != i) && (x != j) && isIndexValid) {
						Creature *neighbor = _gridArray[y][x];
						if (neighbor.isAlive) {
							current.livingNeighbors++;
						}
					}
				}
			}
		}
	}
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y {
	if (x < 0 || y < 0 || x >= GRID_COLUMNS || y >= GRID_ROWS) {
		return NO;
	}

	return YES;
}

- (void)updateCreatures {
	for (u_int i = 0; i < [_gridArray count]; ++i) {
		for (u_int j = 0; j < [_gridArray count]; ++j) {
			Creature *current = _gridArray[i][j];
			BOOL alive = NO;
			if (current.isAlive) {
				if (current.livingNeighbors < 2) {
					alive = NO;
				} else if (current.livingNeighbors == 2 || current.livingNeighbors == 3) {
					alive = YES;
				} else if (current.livingNeighbors > 3) {
					alive = NO;
				}
			} else {
				if (current.livingNeighbors == 3) {
					alive = YES;
				}
			}
			current.isAlive = alive;
		}
	}
}

-(void)update:(CCTime)delta {
	[self evolveStep];
}

@end
