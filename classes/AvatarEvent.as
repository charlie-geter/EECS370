﻿package {	import flash.events.Event;	public class AvatarEvent extends Event	{		public static const DEAD:String = "dead";		public static const GOAL_REACHED:String = "goal_reached";				public function AvatarEvent(type:String)		{			super(type);		}	}}