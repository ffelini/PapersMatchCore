package model.cells ;
import controller.ControllerLevel;
import model.display.DisplayObjectAbstract;
import model.display.IDisplay;

/**
 * ...
 * @author val
 */
class Cell extends DisplayObjectAbstract
{
	inline public static var TYPE_DEAD:String = "dead";
	inline public static var TYPE_EMPTY:String = "empty";
	inline public static var TYPE_LOCKED:String = "locked";
	
	inline public static var DIRECTION_LEFT:String = "left";
	inline public static var DIRECTION_RIGHT:String = "right";
	inline public static var DIRECTION_TOP:String = "top";
	inline public static var DIRECTION_BOTTOM:String = "bottom";
	inline public static var DIRECTION_TOP_RIGHT:String = "topRight";
	inline public static var DIRECTION_TOP_LEFT:String = "topLeft";
	inline public static var DIRECTION_BOTTOM_RIGHT:String = "bottomRight";
	inline public static var DIRECTION_BOTTOM_LEFT:String = "bottomLeft";
	
	inline public static var MIN_MATCH_LENGTH:Int = 3;
	
	public static var CELL_COLORS:Array<UInt> = [0xFFFF00,0xFF9900,0x6699FF,0xCC3300,0x9966CC];
	
	public var fieldX:Float;
	public var fieldY:Float;
		
	private var _controller:ControllerLevel;
	
	
	public function new(levelController:ControllerLevel) 
	{
		super();
		_controller = levelController;
	}
	private var _iCellDisplay:ICellDisplay;
	override public function set_iDisplay(value:IDisplay):IDisplay
	{
		super.set_iDisplay(value);
		value.source = this;
		_iCellDisplay = Std.instance(value, ICellDisplay);
		return _iDisplay;
	}
	private var _type:String;
	public var type:String = TYPE_EMPTY;
	public function set_type(value:String):String
	{
		_type = value;
		if(_iCellDisplay!=null) _iCellDisplay.updateView();
		return _type;
	}
	public function get_type():String
	{
		return _type;
	}
	
	private var _level:Int = 0;
	public var level(get, set):Int;
	public function set_level(value:Int):Int
	{
		_level = value;
		if(_iCellDisplay!=null) _iCellDisplay.updateView();
		return _level;
	}
	public function get_level():Int
	{
		return _level;
	}
	
	public var left:Cell;
	public var right:Cell;
	public var top:Cell;
	public var bottom:Cell;
	
	public function randomizeState():Void
	{
		
	}
	
	public function reset():Void
	{
		level = 0;
		type = "";
		left = right = top = bottom = null;		
	}
	
	public var topRight(get, null):Cell;
	public function get_topRight():Cell
	{
		return top != null ? top.right : null;
	}
	public var topLeft(get, null):Cell;
	public function get_topLeft():Cell
	{
		return top != null ? top.left : null;
	}
	public var bottomRight:Cell;
	public function get_bottomRight():Cell
	{
		return bottom != null ? bottom.right : null;
	}
	public var bottomLeft:Cell;
	public function get_bottomLeft():Cell
	{
		return bottom != null ? bottom.left : null;
	}
	
	// ----------------------------------------------- MATCHING LINEAR -----------------------------------------------------
	
	public var leftMatchLength(get, null):Int;
	public function get_leftMatchLength():Int
	{
		return checkMatch(this, left) ? 1 + left.leftMatchLength : 0;
	}
	public var rightMatchLength(get, null):Int;
	public function get_rightMatchLength():Int
	{
		return checkMatch(this, right) ? 1 + right.rightMatchLength : 0;
	}
	public var topMatchLength(get, null):Int;
	public function get_topMatchLength():Int
	{
		return checkMatch(this, top) ? 1 + top.topMatchLength : 0;
	}
	public var bottomMatchLength(get, null):Int;
	public function get_bottomMatchLength():Int
	{
		return checkMatch(this, bottom) ? 1 + bottom.bottomMatchLength : 0;
	}
	
	public var horizontalMatchLength(get, null):Int;
	public function get_horizontalMatchLength():Int
	{
		return rightMatchLength + leftMatchLength;
	}
	public var verticalMatchLength(get, null):Int;
	public function get_verticalMatchLength():Int
	{
		return topMatchLength + bottomMatchLength;
	}
	
	public function updatePosition():Void
	{
		if(_iCellDisplay!=null) _iCellDisplay.updatePosition();
	}
	public function updateView():Void
	{
		if (_iCellDisplay != null) _iCellDisplay.updateView();
	}
	// ----------------------------------------------- MATCHING DIAGONAL -----------------------------------------------------
	
	public var topRightMatchLength(get, null):Int;
	public function get_topRightMatchLength():Int
	{
		return checkMatch(this, topRight) ? 1 + topRight.topRightMatchLength : 0;
	}
	public var topLeftMatchLength(get, null):Int;
	public function get_topLeftMatchLength():Int
	{
		return checkMatch(this, topLeft) ? 1 + topLeft.topLeftMatchLength : 0;
	}
	public var bottomRightMatchLength(get, null):Int;
	public function get_bottomRightMatchLength():Int
	{
		return checkMatch(this, bottomRight) ? 1 + bottomRight.bottomRightMatchLength : 0;
	}
	public var bottomLeftMatchLength(get, null):Int;
	public function get_bottomLeftMatchLength():Int
	{
		return checkMatch(this, bottomLeft) ? 1 + bottomLeft.bottomLeftMatchLength : 0;
	}
	
	// ----------------------------------------------- SWAPS -----------------------------------------------------
	
	public function swapLeft(onlyInMatchCase:Bool=true):Void
	{
		if (left != null)
		{
			var isMatchCase:Bool = checkLeftMatch();
			if (onlyInMatchCase && !isMatchCase) return;
			
			var lastRight:Cell = right;
			var lastLeft:Cell = left;
			
			right = lastLeft;
			left = lastLeft.left;
			left.right = this;
			
			lastLeft.left = this;
			lastLeft.right = lastRight;
			
			lastRight.left = lastLeft;
			
			updatePosition();
			
			matchAll();
			lastLeft.matchAll();
		}
	}
	public function swapRight(onlyInMatchCase:Bool=true):Void
	{
		if (right != null)
		{
			var isMatchCase:Bool = checkRightMatch();
			if (onlyInMatchCase && !isMatchCase) return;
			
			var lastRight:Cell = right;
			var lastLeft:Cell = left;
			
			left = lastRight;
			right = lastRight.right;
			right.left = this;
			
			lastRight.right = this;
			lastRight.left = lastLeft;
			
			lastLeft.right = lastRight;
			
			updatePosition();
			
			matchAll();
			lastRight.matchAll();
		}
	}
	public function swapTop(onlyInMatchCase:Bool=true):Void
	{
		if (top != null)
		{
			var isMatchCase:Bool = checkTopMatch();
			if (onlyInMatchCase && !isMatchCase) return;
			
			var lastBottom:Cell = bottom;			
			var lastTop:Cell = top;
			
			bottom = lastTop;
			top = lastTop.top;
			top.bottom = this;
			
			lastTop.top = this;
			lastTop.bottom = lastBottom;
			
			lastBottom.top = lastTop;
			
			updatePosition();
			
			matchAll();
			lastTop.matchAll();
		}
	}
	public function swapBottom(onlyInMatchCase:Bool=true):Void
	{
		if (bottom != null)
		{
			var isMatchCase:Bool = checkBottomMatch();
			if (onlyInMatchCase && !isMatchCase) return;
			
			var lastBottom:Cell = bottom;			
			var lastTop:Cell = top;
			
			top = lastBottom;
			bottom = lastBottom.bottom;
			bottom.top = this;
			
			lastBottom.bottom = this;
			lastBottom.top = lastTop;
			
			lastTop.bottom = lastBottom;
			
			updatePosition();
			
			matchAll();
			lastBottom.matchAll();
		}
	}
	
	// ----------------------------------------------- MATCH -----------------------------------------------------
	
	public function matchAll():Void
	{
		var hMatchLength:Int = horizontalMatchLength;
		var vMatchLength:Int = verticalMatchLength;
		
		if (hMatchLength >= MIN_MATCH_LENGTH)
		{
			leftMatch(this);
			rightMatch(this);
		}
		if (vMatchLength >= MIN_MATCH_LENGTH)
		{
			topMatch(this);
			bottomMatch(this);
		}
	}
	public function distanceTo(cell:Cell, direction:String):Int
	{
		if (cell == this) return 0;
		
		if (direction == DIRECTION_RIGHT) return checkMatch(this, cell) ? 1 + distanceTo(cell.right,DIRECTION_RIGHT) : 0;
		else if (direction == DIRECTION_LEFT) return checkMatch(this, cell) ? 1 + distanceTo(cell.left,DIRECTION_LEFT) : 0;
		else if (direction == DIRECTION_TOP) return checkMatch(this, cell) ? 1 + distanceTo(cell.top,DIRECTION_TOP) : 0;
		else if (direction == DIRECTION_BOTTOM) return checkMatch(this, cell) ? 1 + distanceTo(cell.bottom,DIRECTION_BOTTOM) : 0;
		
		return 0;
	}
	inline public static function checkMatch(cellA:Cell, cellB:Cell):Bool
	{
		if (cellA == null || cellB == null) return false;
		
		return cellA.type == cellB.type && cellA.level == cellB.level;
	}
	public function kill(initiatorCell:Cell,direction:String):Void
	{
		type = TYPE_DEAD;
	}
	private function leftMatch(initiatorCell:Cell):Void
	{
		if (left!=null)
		{
			if (checkMatch(this,left))
			{
				kill(initiatorCell,DIRECTION_RIGHT);
				left.leftMatch(initiatorCell);
			}
		}
	}
	private function rightMatch(initiatorCell:Cell):Void
	{
		if (right!=null)
		{
			if (checkMatch(this,right))
			{
				kill(initiatorCell,DIRECTION_LEFT);
				right.leftMatch(initiatorCell);
			}
		}
	}
	private function topMatch(initiatorCell:Cell):Void
	{
		if (top!=null)
		{
			if (checkMatch(this,top))
			{
				kill(initiatorCell,DIRECTION_BOTTOM);
				top.leftMatch(initiatorCell);
			}
		}
	}
	private function bottomMatch(initiatorCell:Cell):Void
	{
		if (bottom!=null)
		{
			if (checkMatch(this,bottom))
			{
				kill(initiatorCell,DIRECTION_TOP);
				bottom.leftMatch(initiatorCell);
			}
		}
	}
	
	public function checkLeftMatch(matchLength:Int=3):Bool
	{
		return leftMatchLength == matchLength;
	}
	public function checkRightMatch(matchLength:Int=3):Bool
	{
		return rightMatchLength == matchLength;
	}
	public function checkTopMatch(matchLength:Int=3):Bool
	{
		return topMatchLength == matchLength;
	}
	public function checkBottomMatch(matchLength:Int=3):Bool
	{
		return bottomMatchLength == matchLength;
	}
	public function checkHorizontalMatch(matchLength:Int=3):Bool
	{
		return horizontalMatchLength == matchLength;
	}
	public function checkVerticalMatch(matchLength:Int=3):Bool
	{
		return verticalMatchLength == matchLength;
	}
	
	public function checkTopLeftMatch(matchLength:Int=3):Bool
	{
		return topLeftMatchLength == matchLength;
	}
	public function checkTopRightMatch(matchLength:Int=3):Bool
	{
		return topRightMatchLength == matchLength;
	}
	public function checkBottomLeftMatch(matchLength:Int=3):Bool
	{
		return bottomLeftMatchLength == matchLength;
	}
	public function checkBottomRigthMatch(matchLength:Int=3):Bool
	{
		return bottomRightMatchLength == matchLength;
	}
}