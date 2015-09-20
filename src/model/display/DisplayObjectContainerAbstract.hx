package model.display;

/**
 * ...
 * @author val
 */
class DisplayObjectContainerAbstract extends DisplayObjectAbstract
{

	public function new() 
	{
		super();
		
	}
	public function addChild(child:DisplayObjectAbstract):Void
	{
		if(iDisplayContainer!=null) iDisplayContainer.adChild(child.iDisplay);
	}
	public function addChildAt(child:DisplayObjectAbstract,index:Int):Void
	{
		if(iDisplayContainer!=null) iDisplayContainer.adChildAt(child.iDisplay, index);
	}
	public var iDisplayContainer(get, null):IDisplayContainer;
	public function get_iDisplayContainer():IDisplayContainer
	{
		if (iDisplayContainer != null) return iDisplayContainer;
		
		iDisplayContainer = cast(iDisplay, IDisplayContainer);
		
		return iDisplayContainer;
	}
}