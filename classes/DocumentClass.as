﻿package {	//main part of the game, so we can have stuff like game over screens and pause screens. 	// separates out the stuff we're adding from the rest.	import flash.display.MovieClip;	//import flash.desktop;	import flash.system.fscommand;	import flash.events.KeyboardEvent;	import flash.events.Event;	public class DocumentClass extends MovieClip 	{		public var playScreen:PlatformerMain; 		var gameOverScreen:GameOverText;		var levelCompleteScreen:LevelCompleteText;		var levelNumber:Number;				public function DocumentClass() 		{			levelNumber = 0;			playScreen = new PlatformerMain(levelNumber);			playScreen.addEventListener(AvatarEvent.DEAD, onAvatarDeath); 			playScreen.addEventListener(AvatarEvent.GOAL_REACHED, onAvatarWin);						addChild( playScreen );						gameOverScreen = null;		}				public function onAvatarDeath(avatarEvent:AvatarEvent):void		{			gameOverScreen = new GameOverText();			gameOverScreen.x = 0;			gameOverScreen.y = 0;			addChild( gameOverScreen ); 						addEventListener(KeyboardEvent.KEY_DOWN, keyDownGameOverListener);			//addEventListener(AvatarEvent.RESTART, onRestart);			//addEventListener(AvatarEvent.QUIT, onQuit);			// playScreen = null;						// Put code here later to restart level...?		}				public function keyDownGameOverListener(e:KeyboardEvent):void		{			switch (e.keyCode)			{				case 81:					//dispatchEvent(new AvatarEvent(AvatarEvent.QUIT));					onQuit(new AvatarEvent(AvatarEvent.QUIT));					break;				case 82:					//dispatchEvent(new AvatarEvent(AvatarEvent.RESTART));					onRestart(new AvatarEvent(AvatarEvent.RESTART));					break;			}		}				public function onRestart(avatarEvent:AvatarEvent):void		{			removeChild( playScreen );			removeChild( gameOverScreen );			playScreen = new PlatformerMain(levelNumber);			playScreen.addEventListener(AvatarEvent.DEAD, onAvatarDeath); 			playScreen.addEventListener(AvatarEvent.GOAL_REACHED, onAvatarWin);						addChild( playScreen );						gameOverScreen = null;		}				public function onQuit(avatarEvent:AvatarEvent):void		{			//applicationExit();			fscommand("quit");		}		/*		public function applicationExit():void {			var exitingEvent:Event = new Event(Event.EXITING, false, true);			NativeApplication.nativeApplication.dispatchEvent(exitingEvent);			if (!exitingEvent.isDefaultPrevented()) {				NativeApplication.nativeApplication.exit();			}		}				private function onExiting(exitingEvent:Event):void {			var winClosingEvent:Event;			for each (var win:NativeWindow in NativeApplication.nativeApplication.openedWindows) {				winClosingEvent = new Event(Event.CLOSING,false,true);				win.dispatchEvent(winClosingEvent);				if (!winClosingEvent.isDefaultPrevented()) {					win.close();				} else {					exitingEvent.preventDefault();				}			}						if (!exitingEvent.isDefaultPrevented()) {				//perform cleanup			}		}*/				public function onAvatarWin(avatarEvent:AvatarEvent):void		{			levelNumber += 1;			levelCompleteScreen = new LevelCompleteText();			levelCompleteScreen.x = 0;			levelCompleteScreen.y = 0;			addChild( levelCompleteScreen ); 			//playScreen = null;		}	}}