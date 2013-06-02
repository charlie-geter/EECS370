﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import com.coreyoneil.collision.CollisionList;	public class PlatformerMain extends MovieClip {		var myPlayer:Player;		var upPressed:Boolean = false;		var upWasPressed:Boolean = false;		var downPressed:Boolean = false;		var leftPressed:Boolean = false;		var rightPressed:Boolean = false;		var isPlayerDead:Boolean = false;		var isPlayerFinished:Boolean = false;		var collisions:CollisionList;		var environment:Array;		var myEnemies:Array;		var xmin:Number;//left side of the stage		var xmax:Number;//right side of the stage		var offset:Number;//how much the environment is offset 		var levelNum:Number;		//(to keep the player in a reasonable place on the screen)						public function PlatformerMain(level:Number) {			// constructor code			environment = [];			myEnemies = [];			levelNum = level;			myPlayer = new Player( 150, 300);			//addChild(myPlayer);			collisions = new CollisionList(myPlayer);			/*collisions.returnAngle = true;			collisions.returnAngleType = "Degrees";*/			addEventListener( Event.ADDED_TO_STAGE, onAddToStage );			addEventListener(Event.ENTER_FRAME, executeFrame);		}				public function constructDemo(){			var newtile:Tile = new Tile(50,550);			environment.push(newtile);			newtile = new Tile(150,550);			environment.push(newtile);			//gap			newtile = new Tile(300,550);			environment.push(newtile);			//second gap			newtile = new Tile(450,550);			environment.push(newtile);			//stairs			newtile = new Tile(550,500);			environment.push(newtile);			newtile = new Tile(650,450);			environment.push(newtile);			//down stairs			newtile = new Tile(750,500);			environment.push(newtile);			newtile = new Tile(850,550);			environment.push(newtile);			newtile = new Tile(950,550);			environment.push(newtile);			//second gap			newtile = new Tile(1100,550);			environment.push(newtile);			newtile = new Tile(1200,550);			environment.push(newtile);			var finish:Goal = new Goal(1200,450);			environment.push(finish);			for(var i = 0; i < environment.length; i++){				collisions.addItem(environment[i]);				addChild(environment[i]);			}			offset = 0;			xmin = 0;			xmax = 1250;			addChild(myPlayer);		}		public function constructLevel1() {			var newtile:Tile = new Tile(50,550);			environment.push(newtile);			newtile = new Tile(150,550);			environment.push(newtile);			//gap			newtile = new Tile(300,550);			environment.push(newtile);			//second gap			newtile = new Tile(450,550);			environment.push(newtile);			//stairs			newtile = new Tile(550,500);			environment.push(newtile);			newtile = new Tile(650,450);			environment.push(newtile);			//down stairs			newtile = new Tile(750,500);			environment.push(newtile);			newtile = new Tile(850,550);			environment.push(newtile);			newtile = new Tile(950,550);			environment.push(newtile);			//second gap			newtile = new Tile(1100,550);			environment.push(newtile);			newtile = new Tile(1200,550);			environment.push(newtile);			var finish:Goal = new Goal(1200,450);			environment.push(finish);			var enemy1:Enemy = new Enemy(1000,375, true);			environment.push(enemy1);			myEnemies.push(enemy1);						for(var i = 0; i < environment.length; i++){				collisions.addItem(environment[i]);				addChild(environment[i]);			}			offset = 0;			xmin = 0;			xmax = 1250;			addChild(myPlayer);		}				public function onAddToStage( event:Event ):void		{			stage.addEventListener( KeyboardEvent.KEY_DOWN, setKeyPressed  );			stage.addEventListener( KeyboardEvent.KEY_UP, unsetKeyPressed );			xmin = 0;			xmax = stage.width;			switch (levelNum)			{				case 0:				constructDemo();				break;								case 1:				constructLevel1();				break;			}								}				function executeFrame(event:Event)		{			if (!isPlayerFinished && !isPlayerDead) 			{				movePlayer(event);				handleCollisions();				moveEnemies();			}		}				function handleCollisions()		{			//do stuff here			var collisionArray:Array = collisions.checkCollisions();			var other;			for(var i = 0; i < collisionArray.length; i++){				if(collisionArray[i].object1 == myPlayer)				{					other = collisionArray[i].object2;				}else{					other = collisionArray[i].object1;				}				if(other is Goal && !isPlayerFinished)				{					isPlayerFinished = true;					dispatchEvent(new AvatarEvent(AvatarEvent.GOAL_REACHED));					break;				}				if(other is Enemy)				{					isPlayerDead = true;					dispatchEvent( new AvatarEvent( AvatarEvent.DEAD ) );				}				if ( Math.abs(other.y -myPlayer.y) < ( (other.height/2) + (myPlayer.height/2) ) && Math.abs(other.x -myPlayer.x) < (other.width/2) ) 				{					if(Math.abs(myPlayer.x - other.x) < (other.width/2))					{						if(myPlayer.dy > 0 && myPlayer.y < other.y)						{							myPlayer.y = other.y - other.height/2 - myPlayer.height/2;							myPlayer.dy = 0;							myPlayer.Land(other);						}else if(myPlayer.dy < 0 && myPlayer.y > other.y)						{							myPlayer.y = other.y + other.height/2 + myPlayer.height/2;							myPlayer.dy = 0;						}else{							//do nothing						}					}				}			}			collisionArray = collisions.checkCollisions();			for(i = 0; i < collisionArray.length; i++){				if(collisionArray[i].object1 == myPlayer)				{					other = collisionArray[i].object2;				}else{					other = collisionArray[i].object1;				}				if(other is Goal && !isPlayerFinished)				{					isPlayerFinished = true;					dispatchEvent(new AvatarEvent(AvatarEvent.GOAL_REACHED));					break;				}				//colliding in the X direction				if ( Math.abs(other.x -myPlayer.x) < ( (other.width/2) + (myPlayer.width/2) ) && Math.abs(other.y -myPlayer.y) < (other.height/2) ) 				{					if( Math.abs(myPlayer.y - other.y) < (other.height/2))					{						if(myPlayer.dx > 0 && myPlayer.x < other.x)						{							myPlayer.x = other.x - other.width/2 - myPlayer.width/2;							myPlayer.dx = 0;							myPlayer.onWall = 1;							myPlayer.HitWall(other);						}else if(myPlayer.dx < 0 && myPlayer.x > other.x){							myPlayer.x = other.x + other.width/2 + myPlayer.width/2;							myPlayer.dx = 0;							myPlayer.onWall = -1;							myPlayer.HitWall(other);						}else{						 //do nothing						}					}				}			}								}				function moveEnvironment(amt:Number)		{			//if you've reached the edge of the stage in either direction			if(((offset + amt) > (xmax - stage.stageWidth))||((offset + amt) < xmin))			{				myPlayer.x += amt;			}			else{				var item;								for(var i = 0; i < environment.length; i++)				{					item = environment[i];					item.x -= amt;				}				offset += amt;			}		}				function moveEnemies()		{			for (var i = 0; i < myEnemies.length; i++)			{				if (myEnemies[i].timer >= myEnemies[i].roamTime) 				{					myEnemies[i].goingLeft = !myEnemies[i].goingLeft; // change direction					myEnemies[i].timer = 0; // reset timer				}				if (myEnemies[i].goingLeft)				{					myEnemies[i].x -= 1; // Go Left if we're supposed to.				}				else 				{					myEnemies[i].x += 1; // Otherwise go right				}				myEnemies[i].timer += 1; // Increment timer.			}		}				function movePlayer(event:Event)		{			if(myPlayer.onPlatform){				myPlayer.CheckFloor();			}						if (!myPlayer.onPlatform)			{				myPlayer.dy += 5;			}			if (upPressed)			{				if(upWasPressed){					if( myPlayer.dy <= -10){						myPlayer.dy -=2.5;					}				}else{					if(myPlayer.onPlatform){						myPlayer.dy = -25;						myPlayer.onPlatform = false;						upWasPressed = true;					}				}			}			/*if (downPressed)			{				myPlayer.dy = Math.min(myPlayer.dy+2, 10);			}*/			if (leftPressed)			{				if(myPlayer.dx >= 0){					myPlayer.dx = Math.floor(myPlayer.dx / 2) - 3;				}else{					myPlayer.dx = Math.max(myPlayer.dx-3, -15);				}			}			if (rightPressed)			{				if(myPlayer.dx <= 0){					myPlayer.dx = Math.floor(myPlayer.dx / 2) + 3;				}else{					myPlayer.dx = Math.min(myPlayer.dx+3, 15);				}			}			if (!rightPressed && !leftPressed)			{				myPlayer.dx = 0;			}			/*if (!downPressed && !upPressed)			{				myPlayer.dy = 0;			}*/			if(myPlayer.onWall == 0){				if((myPlayer.x >= (stage.stageWidth * .75) && myPlayer.dx > 0) || (myPlayer.x <= (stage.stageWidth * .25) && myPlayer.dx < 0))				{					moveEnvironment(myPlayer.dx);				}else{					myPlayer.x += myPlayer.dx;				}			}else if(myPlayer.onWall == 1){				if(myPlayer.dx < 0){					myPlayer.onWall = 0;				}else{					myPlayer.CheckWall();				}				if((myPlayer.x >= (stage.stageWidth * .75) && myPlayer.dx > 0) || (myPlayer.x <= (stage.stageWidth * .25) && myPlayer.dx < 0))				{					moveEnvironment(myPlayer.dx);				}else{					myPlayer.x += myPlayer.dx;				}			}else if(myPlayer.onWall == -1){				if(myPlayer.dx > 0){				myPlayer.onWall = 0;				}else{					myPlayer.CheckWall();				}				if((myPlayer.x >= (stage.stageWidth * .75) && myPlayer.dx > 0) || (myPlayer.x <= (stage.stageWidth * .25) && myPlayer.dx < 0))				{					moveEnvironment(myPlayer.dx);				}else{					myPlayer.x += myPlayer.dx;				}			}else{				//do nothing			}						myPlayer.y += myPlayer.dy;			if(myPlayer.y > (600 - myPlayer.height / 2))			{				isPlayerDead = true;				//gameTimer.stop();				dispatchEvent( new AvatarEvent( AvatarEvent.DEAD ) );				/*myPlayer.y = 600 - myPlayer.height / 2;				myPlayer.Land();				upWasPressed = false;*/			}		}		function setKeyPressed(event:KeyboardEvent):void		{			switch (event.keyCode)			{				case Keyboard.UP:				{					if(upPressed){						//upWasPressed = true;					}else{						upPressed = true;						upWasPressed = false;					}					break;				}				case Keyboard.DOWN:				{					downPressed = true;					break;				}				case Keyboard.LEFT:				{					leftPressed = true;					break;				}				case Keyboard.RIGHT:				{					rightPressed = true;					break;				}			}		}				function unsetKeyPressed(event:KeyboardEvent):void		{			switch (event.keyCode)			{				case Keyboard.UP:				{					upPressed = false;					break;				}				case Keyboard.DOWN:				{					downPressed = false;					break;				}				case Keyboard.LEFT:				{					leftPressed = false;					break;				}				case Keyboard.RIGHT:				{					rightPressed = false;					break;				}			}		}	}	}