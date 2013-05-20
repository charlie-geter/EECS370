﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	public class PlatformerMain extends MovieClip {		var myPlayer:Player;		var upPressed:Boolean = false;		var downPressed:Boolean = false;		var leftPressed:Boolean = false;		var rightPressed:Boolean = false;		public function PlatformerMain() {			// constructor code			myPlayer = new Player( 200, 200);			addChild(myPlayer);			addEventListener( Event.ADDED_TO_STAGE, onAddToStage );			addEventListener(Event.ENTER_FRAME, movePlayer);		}				public function onAddToStage( event:Event ):void		{			stage.addEventListener( KeyboardEvent.KEY_DOWN, setKeyPressed );			stage.addEventListener( KeyboardEvent.KEY_UP, unsetKeyPressed );		}		function movePlayer(event:Event)		{			if (upPressed)			{				myPlayer.dy = Math.max(myPlayer.dy-2, -10);			}			if (downPressed)			{				myPlayer.dy = Math.min(myPlayer.dy+2, 10);			}			if (leftPressed)			{				myPlayer.dx = Math.max(myPlayer.dx-2, -10);			}			if (rightPressed)			{				myPlayer.dx = Math.min(myPlayer.dx+2, 10);			}			if (!rightPressed && !leftPressed)			{				myPlayer.dx = 0;			}			if (!downPressed && !upPressed)			{				myPlayer.dy = 0;			}			myPlayer.x += myPlayer.dx;			myPlayer.y += myPlayer.dy;				}		function setKeyPressed(event:KeyboardEvent):void		{			switch (event.keyCode)			{				case Keyboard.UP:				{					upPressed = true;					break;				}				case Keyboard.DOWN:				{					downPressed = true;					break;				}				case Keyboard.LEFT:				{					leftPressed = true;					break;				}				case Keyboard.RIGHT:				{					rightPressed = true;					break;				}			}		}				function unsetKeyPressed(event:KeyboardEvent):void		{			switch (event.keyCode)			{				case Keyboard.UP:				{					upPressed = false;					break;				}				case Keyboard.DOWN:				{					downPressed = false;					break;				}				case Keyboard.LEFT:				{					leftPressed = false;					break;				}				case Keyboard.RIGHT:				{					rightPressed = false;					break;				}			}		}	}	}