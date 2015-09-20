package model.level;

/**
 * ...
 * @author val
 */
class ModelLevel
{

	public var moves:Int;
	public var score:Int;
	
	public function new()  
	{
		
	}
	private var _level:Level;
	public var level(get, null):Level;
	public function get_level():Level
	{
		return _level;
	}
	public function setLevel(level:Level):Void
	{
		reset();
		_level = level;
	}
	public function addScore(value:Int):Void
	{
		score += value;
	}
	public function registerMove():Void
	{
		moves --;
	}
	public var isLevelComplete(get, null):Bool;
	public function get_isLevelComplete():Bool
	{
		return moves == 0 || score >= _level.scoreMinimum;
	}
	public var levelWon(get, null):Bool;
	public function get_levelWon():Bool
	{
		return score == _level.scoreMinimum;
	}
	public var progress(get, null):Int;
	public function get_progress():Int
	{
		return Std.int(score / _level.scoreMaximum);
	}
	private function reset():Void
	{
		moves = 0;
		score = 0;
	}
}