package model.cells;
import controller.ControllerLevel;

/**
 * ...
 * @author val
 */
class CellSquare extends Cell
{

	public function new(levelController:ControllerLevel) 
	{
		super(levelController);
	}
	override public function kill(initiatorCell:Cell,direction:String):Void
	{
		type = Cell.TYPE_DEAD;
		
		if (direction == Cell.DIRECTION_RIGHT) 1;
		else if (direction == Cell.DIRECTION_LEFT) 1;
		else if (direction == Cell.DIRECTION_TOP) 1;
		else if (direction == Cell.DIRECTION_BOTTOM) 1;
	}
}