package hit.petkosite.customcomponents
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import mx.controls.MenuBar;
	import mx.controls.menuClasses.IMenuBarItemRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.styles.ISimpleStyleClient;

	public class VMenuBar extends MenuBar
	{
		public function VMenuBar()
		{
			super();
		}
	/**
     *  @private
     */
    private var background:IFlexDisplayObject;
    
    [Inspectable(category="Size")]
    public var itemVPadding:Number = 5;
    
    [Inspectable(category="Size")]
	public var verticalMargin:int = 0;
    /**
     *  Calculates the preferred width and height of the MenuBar based on the
     *  default widths of the MenuBar items. 
     */
    override protected function measure():void
    {
        super.measure();

        var len:int = menuBarItems.length;

        measuredHeight = 0;

        // measured height is at least 22
        measuredWidth = DEFAULT_MEASURED_MIN_WIDTH; 
        for (var i:int = 0; i < len; i++)
        {
            measuredHeight += menuBarItems[i].getExplicitOrMeasuredHeight() + itemVPadding * 2;
            measuredWidth = Math.max(
                    measuredWidth, menuBarItems[i].getExplicitOrMeasuredWidth());
        }

        if (len > 0)
            measuredHeight += 2 * verticalMargin;
        else // else give it a default width, MARGIN_WIDTH = 10.
            measuredHeight = DEFAULT_MEASURED_MIN_HEIGHT; // setting it slightly more than the width

        measuredMinWidth = measuredWidth;
        measuredMinHeight = measuredHeight;
    }

    /**
     *  @private
     *  Sizes and positions the items on the MenuBar.
     */
    override protected function updateDisplayList(unscaledWidth:Number,
                                                  unscaledHeight:Number):void
    {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        var lastX:Number = verticalMargin;
        var lastW:Number = 0;
        var len:int = menuBarItems.length;

        var clipContent:Boolean = false;
        var hideItems:Boolean = (unscaledWidth == 0 || unscaledHeight == 0);

        for (var i:int = 0; i < len; i++)
        {
            var item:IMenuBarItemRenderer = menuBarItems[i];

            item.setActualSize(unscaledWidth, item.getExplicitOrMeasuredHeight() + itemVPadding * 2);
            item.visible = !hideItems;
            
			item.x = 0;
			
            lastX = item.y = lastX+lastW;
            lastW = item.height;

            if (!hideItems &&
                (item.getExplicitOrMeasuredWidth() > unscaledWidth ||
                 (lastX + lastW) > unscaledHeight))
            {
                //clipContent = true;
            }
        }
		if (background)
        {
            background.setActualSize(unscaledWidth, unscaledHeight);
            background.visible = !hideItems;
        }

        // Set a scroll rect to handle clipping.
        scrollRect = clipContent ? new Rectangle(0, 0,
                unscaledWidth, unscaledHeight) : null;
    }
    
		/**
     *  Updates the MenuBar control's background skin. 
     * 
     *  This method is called when MenuBar children are created or when 
     *  any styles on the MenuBar changes. 
     */
    protected override function updateBackground():void
    {
    	/**
        if (isInsideACB)
        {
            // draw translucent menubar
            setStyle("translucent", true);
        }
        else
        {*/
            // Remove existing background
            if (background)
            {
                removeChild(DisplayObject(background));
                background = null;
            }
            
            var backgroundSkinClass:Class = getStyle("backgroundSkin");
            background = new backgroundSkinClass();
            if (background is ISimpleStyleClient) {
                ISimpleStyleClient(background).styleName = this;
            }
            
            addChildAt(DisplayObject(background), 0);
        
    }
	}
}