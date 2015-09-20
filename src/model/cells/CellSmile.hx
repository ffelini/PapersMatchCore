package model.cells;

import controller.ControllerLevel;

/**
 * ...
 * @author val
 */
class CellSmile extends Cell
{
	inline public static var SMILE_HAPPY:String = "happy";
	inline public static var SMILE_ANGRY:String = "angry";
	inline public static var SMILE_FEAR:String = "fear";
	inline public static var SMILE_COURAGE:String = "courage";
	inline public static var SMILE_SHAME:String = "shame";
	inline public static var SMILE_LOVE:String = "love";
	
	inline public static var GENDER_MALE:String = "male";
	inline public static var GENDER_FEMALE:String = "female";
	

	public function new(levelController:ControllerLevel) 
	{
		super(levelController);
		
	}
	override public function kill(initiatorCell:Cell,direction:String):Void
	{
		type = TYPE_DEAD;
		
		if (direction == DIRECTION_RIGHT) ;
		else if (direction == DIRECTION_LEFT) ;
		else if (direction == DIRECTION_TOP) ;
		else if (direction == DIRECTION_BOTTOM) ;
	}
}