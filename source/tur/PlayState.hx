package tur;

import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.text.FlxText;
import tur.data.path.Path;
import flixel.FlxState;

class PlayState extends FlxState
{
	var path:Path;

	var dialogue:FlxTypeText;

	var dialogueIndex = 0;

	var lineComplete = false;
	var dialogueComplete = false;

	public function load(newpath:String)
	{
		if (path == null)
			return;

		path.loadFile('assets/paths/$newpath.json');
		trace('New path');

		dialogueComplete = false;

		dialogueIndex = -1;
		dialogue.resetText('');
		nextLine();
	}

	public function nextLine()
	{
		dialogueIndex++;

		if (dialogueIndex > path.dialogue.length - 1 || path.dialogue.length == 0)
		{
			completeDialogue();
			return;
		}

		lineComplete = false;
		trace('Line start');

		dialogue.resetText(dialogue.text + '\n' + path.dialogue[dialogueIndex] ?? '');
		dialogue.start(0.05, false, false, [], completeLine);
	}

	public function completeLine()
	{
		trace('Line done');
		lineComplete = true;
	}

	public function completeDialogue()
	{
		lineComplete = dialogueComplete = true;

		trace('Dialogue done');

		var choiceText:String = '\n\nChoices:';

		for (choice in path.choices)
			choiceText += '\n- ${choice.text}';

		dialogue.resetText(dialogue.text + choiceText);
		dialogue.start(0.05, false, false, []);
	}

	override public function create()
	{
		super.create();

		path = new Path();

		dialogue = new FlxTypeText(16, 16, FlxG.width, '', 16);
		dialogue.font = 'assets/unifont.ttf';
		dialogue.color = FlxColor.WHITE;
		dialogue.resetText('Unifont');

		load('root');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (lineComplete && !dialogueComplete && FlxG.keys.justPressed.ENTER)
		{
			nextLine();
		}
	}
}
