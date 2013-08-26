package com.dotfold.dotvimstat.view.animation
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;

	/**
	 * Sequence the alpha animation of a list of DisplayObject.
	 *  
	 * @author jamesmcnamee
	 * 
	 */
	public class ElementAnimationSequencer extends EventDispatcher
	{
		
		private var _queue:Array;
		
		/**
		 * Constructor.
		 */
		public function ElementAnimationSequencer()
		{
			super();
			
			_queue = [];
		}
		
		/**
		 * Adds a <code>DisplayObject</code> to the sequence.
		 * 
		 * @param element DisplayObject to add to sequence.
		 * @return this for chaining 
		 * 
		 */
		public function addElement(element:DisplayObject):ElementAnimationSequencer
		{
			_queue.push(element);
			
			return this;
		}
		
		/**
		 * Starts the sequence.
		 */
		public function play():void
		{
			animateNext();
		}
		
		/**
		 * Animate the next item in the sequence, is called recursively after
		 * a delay until the queue is empty.
		 */
		private function animateNext():void
		{
			var next:DisplayObject = _queue.shift();
			if (next)
			{
				TweenLite.to(next, 0.4, { alpha: 1, delay: 0.3} );
				setTimeout(animateNext, 0.3);
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
	}
}