package model.cells;
import model.display.IDisplayContainer;

/**
 * @author val
 */

interface ICellDisplay extends IDisplayContainer
{
	function updatePosition():Void;
	function updateView():Void;
}