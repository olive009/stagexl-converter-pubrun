## Pure Actionscript to Dart Conversion Helper. Dart Project Edition.

As an Actionscript developer, you've probably heard about Dart and StageXL by now and always wanted to give it a shot. Of course, you have a project or just some classes ready, that you want to port just to see what's going on.

Let me tell you this: while working with the DisplayList in StageXL feels rather similar to what you know from Actionscript, everything else is so different that after converting half a class, you will either give up, or start from scratch.

Luckily, this little tool will take about 190% of the pain out of the process. It will get as much out of the way for you as possible, so that you can concentrate on converting just the instructions that matter. Look further down to get an idea where the helper helps.

#### By the way: 
You are looking at the Dart Project Edition of the converter.
If you consider yourself an elite Dartisan, I'd recommend using the pub global edition:
- pub package: SOON
- sources: https://github.com/blockforest/actionscript-to-dart-pub

## What it does for you

### Packages
- replace package declarations with 'part of' directive
- add all classes to the library's package.dart (part 'src/...')
- converts CamelCase filenames to Dart specs (camel_case)

### Classes/Functions/Variables
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

### Type conversion
- '*' to dynamic
- Vector.<type> to List<type>
- Class to Type
- Number to num
- Boolean to bool
- uint to int
- Array to List (including .push to .add)
- Object to Map
- trace to print
- for each to for
- implicit comparators ('===' to '==')

### Misc
- convert (most) Math functions
- testing for null (in Dart, you can only do if(bool), all other need if(type != null))
- type casting: int(value) to (value).toInt()
- type casting: (Class)value to (value as Class)
- type casting: Class(value) to (value as Class)

### StageXL specific
- IEventDispatcher to EventDispatcher (yes, it works)
- getTimer to stage.juggler.elapsedTime*1000
- order of BitmapData.draw and BitmapData.fillColor (pure magic!)


## What it does not do for you.   
Anything else. You'll have to manually deal with
- differences between the API's of StageXL and Flash's DisplayList.
- shortcomings of StageXL's DisplayList API's
- finding equivalents for all Flash API's not covered by StageXL

But hey, at least now you can focus on the important stuff! 

## Usage

Try it out by running bin/as3_to_dart.dart as command line script without parameters.
The pub run docs tell you how to do that: https://www.dartlang.org/tools/pub/cmd/pub-run.html
This will generate the 'examples_autogen' folder under lib.
Of course you want to convert your own stuff, so do a 'pub run as3_to_dart --help'

#### Example #1: Spring Actionscript
To get an idea of how much the converter can help you, look at the basic
architecture of Spring Actionscript that is provided in the example.

From the 28 classes converted automatically, just IObjectFactory generates an error, 
because in Actionscript, interfaces can extend several other interfaces, e.g.
interface IObjectFactory extends IObjectDefinitionRegistryAware, IEventDispatcher
In Dart, this is not possible, so you'll have to change to implements, manually)

#### Example #2: DotLight ( taken from http://wonderfl.net/c/3lDU )
Compare the sources in lib/dotlight_working with those in lib/examples_autogen to get an 
idea of the amount of manual tweaking required to get things running.

Also, get an idea of differences in performance if you're not optimizing
(b/c in this case, it's just stupid to draw to BitmapData before drawing to canvas.)

  
#### Example #3: Christmas Tree ( taken from http://wonderfl.net/c/bSES )
Again, compare lib/xmas_working with lib/examples_autogen to get an idea of the amount of
manual tweaking required to get things running.

This example makes use of the 3D capabilities of Actionscript Sprites – StageXL does not
have 3D, yet, so these parts have been commented in the working example.



## Common Pitfalls you will tap into

Everything is null by default. Even numbers (MEH!).
Will fail:
int i;
i++;

You can't set List like this: list[list.length] = value;
A lot of AS people do it this way, though, because it is way more performant than Array.push

Also, see http://www.stagexl.org/docs/actionscript-dart.html for even more pitfalls.
