package model.cells;
import controller.ControllerLevel;

/**
 * ...
 * @author val
 */
class CellPapper extends Cell
{

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