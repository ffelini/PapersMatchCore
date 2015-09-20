package model.level;
import model.cells.Cell;

/**
 * ...
 * @author val
 */
class Level
{
	public var type:String = "";
	
	public var scoreMinimum:Int;
	public var scoreMaximum:Int;
	public var scores:Array<Int>;
	
	public var moves:Int;
		
	public var width:Int;
	public var height:Int;
	
	public var fieldWidth:Int;
	public var fieldHeight:Int;
	
	public var levelNum:Int;
	public var cells:Array<Cell>;
	
	public function new() 
	{
		
	}
	
}