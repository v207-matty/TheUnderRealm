package tur.data.path;

import lime.utils.Assets;
import haxe.Json;

class Path
{
	public var graphic:String = null;

	public var dialogue:Array<String> = [];

	public var choices:Array<PathChoice> = [];

	public function new(?graphic:String, ?dialogue:Array<String>, ?choices:Array<PathChoice>)
	{
		this.graphic = graphic ?? null;
		this.dialogue = dialogue ?? [];
		this.choices = choices ?? [];
	}

	public function loadFile(file:String)
	{
		loadObject(Json.parse(Assets.getText(file)));
	}

	public function loadObject(object:Dynamic)
	{
		if (object == null)
			return;

		this.graphic = object?.graphic ?? null;
		
		this.dialogue = object?.dialogue;
		this.choices = object?.choices;

		this.dialogue ??= [];
		this.choices ??= [];
	}

	public function toString():String
	{
		return 'Path(graphic: $graphic, dialogue: $dialogue, choices: $choices)';
	}
}
