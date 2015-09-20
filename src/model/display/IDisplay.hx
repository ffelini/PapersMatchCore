package model.display ;

/**
 * @author val
 */

interface IDisplay 
{
	var source(get,set):Dynamic;
	function get_source():Dynamic;
	function removeFromParent():Void;
}