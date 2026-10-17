package tur;

import tur.data.path.Path;
import flixel.FlxState;

class PlayState extends FlxState
{
	var path:Path;

	public function load(newpath:String)
	{
		if (path != null)
			path.loadFile('assets/paths/$newpath.json');
	}

	override public function create()
	{
		super.create();

		path = new Path();
		load('root');

		trace(path);
	}
}
