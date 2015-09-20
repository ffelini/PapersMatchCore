package model.field ;

import haxePort.managers.ObjPool;
import model.cells.Cell;
import model.display.IDisplay;
import model.display.DisplayObjectContainerAbstract;
import model.level.Level;
import model.level.ModelLevel;
import controller.ControllerLevel;


class LevelField extends DisplayObjectContainerAbstract
{
	inline public static var TYPE_SQUARES:String = "squareCells";
	inline public static var TYPE_PAPERS:String = "paperCells";
	inline public static var TYPE_LINKED:String = "linkedCells";
	inline public static var TYPE_SMILES:String = "smileCells";
	
	public var controller:ControllerLevel;
	
	public function new() 
	{
		super();
		controller = new ControllerLevel();
	}
	private var level:Level;
	public function playLevel(_level:Level):Void
	{
		level = _level;
		if (_level == null) return;
		
		controller.playLevel(_level);
		initField();
	}
	public var getCellDisplayFunction:Cell->IDisplay;
	private function initField():Void
	{
		clearField();

		if (level.cells != null)
		{
			for (cell in level.cells)
			{
				if (cell != null)
				{
					if (getCellDisplayFunction != null) cell.iDisplay = getCellDisplayFunction(cell);
					
					addChild(cell);
					cell.updatePosition();
					cell.updateView();
				}
			}
		}
		else
		{
			var cell:Cell;
			for (x in 0 ... level.width)
			{
				for (y in 0 ... level.height)
				{
					cell = new Cell(controller);
					cell.randomizeState();
					if(getCellDisplayFunction!=null) cell.iDisplay = getCellDisplayFunction(cell);
					
					controller.model.level.cells.push(cell);
					
					addChild(cell);
					cell.updatePosition();
					cell.updateView();
				}
			}
		}
	}
	public function clearField():Void
	{
		for (cell in level.cells)
		{
			cell.removeFromParent();
			
			ObjPool.inst.add(cell,Type.getClass(cell));
		}
	}
}