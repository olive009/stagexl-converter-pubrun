Pure Actionscript to Dart Conversion Helper.

Fellow Actionscript Developers,
so you've heard about Dart and StageXL and want to give it a shot.
And you have a project or just some classes you want to port.

While working with the DisplayList in StageXL is rather similar to
what you know from Actionscript, everything else is so different
that after half a class, you will either give up, or start from scratch.

Or.

You try my little tool, taking 90% of the pain out of the process.

What it does for you

Packages
- replace package declarations with 'part of' directive
- add all classes to the library's package.dart (part 'src/...')
- converts CamelCase filenames to Dart specs (camel_case)

Classes/Functions/Variables
- remove closing bracket at end of class
- reposition override keyword
- remove Event Metadata
- remove Bindable Metadata
- replace interface with abstract class
- remove 'final' from class declarations
- delete imports
- delete all scopes
- convert constructors (including calls to super)
- convert functions/getters/setters
- convert optional function parameters
- convert variable declarations, including const and final

Type conversion
- * to dynamic
- Vector.<type> to List<type>
- Class to Type
- Number to num
- Boolean to bool
- uint to int
- Array to List (including .push to .add)
- Object to Map
- trace to print
- for each to for
- implicit comparators (=== to ==)

Misc
- convert (most) Math functions
- testing for null (in Dart, you can only do if(bool), all other need if(type != null)
- type casting: int(value) to (value).toInt()
- type casting: (Class)value to (value as Class)
- type casting: Class(value) to (value as Class)

StageXL specific
- IEventDispatcher to EventDispatcher (yes, it works)
- getTimer to stage.juggler.elapsedTime*1000

- let you focus on porting just your instructions

What it does not do for you.   
Anything else. You'll have to manually deal with
- differences between the API's of StageXL and Flash's DisplayList.
- shortcomings of StageXL's DisplayList API's
- finding equivalents for all Flash API's not covered by StageXL

But hey, at least now you can focus on the important stuff! 

Usage

Try it out by running the 'convert_examples' task. 
This will generate three libraries.

Example #1: Spring Actionscript
To get an idea of how much the converter can help you, look at the basic
architecture of Spring Actionscript that is provided in the example.
From the 78 classes converted automatically, just one generates an error 
(IObjectFactory, because in Actionscript, interfaces can extend several other interfaces, e.g.
interface IObjectFactory extends IObjectDefinitionRegistryAware, IEventDispatcher
In Dart, this is not possible, so you'll have to change to implements, manually)

Example #2: DotLight ( taken from http://wonderfl.net/c/3lDU )
Compare lib/dotlight_working with lib/dotlight_autogen to get an idea of the amount of
manual tweaking required to get things running.
Also, get an idea of differences in performance if you're not optimizing
(b/c in this case, it's just stupid to draw to BitmapData before drawing to canvas.)
TODO: remove myself as author from doc comments. that was automatically added.
  
Example #3: Christmas Tree ( taken from http://wonderfl.net/c/bSES )
Again, compare lib/xmas_working with lib/xmas_autogen to get an idea of the amount of
manual tweaking required to get things running.
As this example makes use of the 3D capabilities of Actionscript Sprites, my hope is
this encourages bp74 even more to add 3D to StageXL :-)
TODO: remove myself as author from doc comments. that was automatically added.


Common Pitfalls you will tap into

Everything is null by default. Even numbers (MEH!).
Will fail:
int i;
i++;

You can't set List like this: list[list.length] = value;
A lot of AS people do it this way, though, because it is way more performant than Array.push

Also, see http://www.stagexl.org/docs/actionscript-dart.html for even more pitfalls.


Things that could get included in a future release:
Deal with differences in StageXL's API, e.g. 
- named parameters of Event.addEventListener
- order of BitmapData.draw and BitmapData.fillColor
- ...



By the way, I'm 400 classes deep into a concrete implementation. 
But not a complete one, just the stuff that I use with my own framework (rockdot).
My goal is to achieve complete, automagic conversion of rockdot AS projects to Dart.
I have a working prototype (50% feature complete, 0% optimized). 