package model.display ;
import model.display.IDisplay;

/**
 * ...
 * @author val
 */
class DisplayObjectAbstract
{

	public var x:Float;
	public var y:Float;
	public var pivotX:Float;
	public var pivotY:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	public var width:Float;
	public var height:Float;
	public var skewX:Float;
	public var skewY:Float;
	public var rotation:Float;
	public var alpha:Float;
	public var visible:Bool;
	public var touchable:Bool;
	public var blendMode:String;
	public var name:String;
	public var useHandCursor:Bool;
	public var parent:Dynamic;

	public function new() 
	{
		
	}
	public function removeFromParent():Void
	{
		if(_iDisplay!=null) _iDisplay.removeFromParent();
	}
	
	private var _iDisplay:IDisplay;
	public var iDisplay(get, set):IDisplay;
	public function get_iDisplay():IDisplay
	{
		return _iDisplay;
	}
	public function set_iDisplay(value:IDisplay):IDisplay
	{
		_iDisplay = value;
		return _iDisplay;
	}
}