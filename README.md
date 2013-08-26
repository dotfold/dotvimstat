# dotvimstat

A quick demo project using the Vimeo Basic API. was supposed to have more of a stats / dashboardy kinda feel to it, but this was as far along as I could get in a weekend.

See the running SWF over at this page thing: [http://dotfold.github.io/dotvimstat/]()

## Dependencies

* [asx](https://github.com/drewbourne/asx)
* [promise-as3](https://github.com/CodeCatalyst/promise-as3)
* [as3corelib](https://github.com/mikechambers/as3corelib/)
* [Swiftsuspenders](https://github.com/tschneidereit/SwiftSuspenders)
* [GreenSock TweenLite](http://www.greensock.com/tweenlite/)
* modena

modena is an apache licensed layout framework, of which I have contributed to. The author has not posted the source, so I cannot link it in this example.

## Local development

`$ git clone https://github.com/dotfold/dotvimstat.git`

dotvimstat uses Ant as the build system. Once the repository is cloned successfully, run:

`$ ant process-sources package-theme`

This sets up the project to be run locally.  

The project is built against Flash Player 10.2, so the playerglobal.swc must be in the SDK path.

The default SWC is built as a debug version.

## Todo
* A lot more tests. Serializers, Mediators, and the view managers are all testable
* More robust tests around the `net` classes
* A fancier collection class for the Models
* Models could also use a bit of a cleanup, public vars are not the best
* Allow configurable username. hardcoded in this initial version
* Animate more of the things



