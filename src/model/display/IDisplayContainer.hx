package model.display;

/**
 * @author val
 */

interface IDisplayContainer extends IDisplay
{
  function adChild(child:Dynamic):Void;
  function adChildAt(child:Dynamic,index:Int):Void;
}