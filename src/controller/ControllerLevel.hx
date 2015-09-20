package controller;
import haxe.Constraints.Function;
import model.level.Level;
import model.level.ModelLevel;

/**
 * ...
 * @author val
 */
class ControllerLevel
{
	public static var LEVEL_UPDATE:String = "updateLevel";
	public static var LEVEL_WON:String = "wonLevel";
	public static var LEVEL_LOOSE:String = "looseLevel";
	
	public function new() 
	{
		_model = new ModelLevel();
	}
	public function playLevel(_level:Level):Void
	{
		_model.setLevel(_level);
	}
	public function checkLevel(onComplete:Function):Void
	{
		if (_model.isLevelComplete)
		{
			if (_model.levelWon)
			{
				
			}
			else
			{
				
			}
		}
	}
	
	private var _model:ModelLevel;
	public var model(get, null):ModelLevel;
	public function get_model():ModelLevel
	{
		return _model;
	}
	
}