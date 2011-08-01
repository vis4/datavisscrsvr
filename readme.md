
Datavis Screensaver
=======================

The idea is simple: instead of looking at stupid screensavers that display some random graphics or images (ok, it might be art in some ways) one could display stupid data visualizations as well. One of the most stupid datasets I'm regularly looking at is the visitor statistics of my websites, so I thought this would be a perfect combination.

### Features

The screensaver (the flash movie) will collect and visualize live data from various sources around the web. Currently supported data sources are

 * Piwik Web Analytics
 
Will add some more in the near future.

### Visualizations

Currently included visualizations:

 * Line chart
 * Bar chart
 * Calendar heatmap
 * Single number
 
### Important
 
Due to security-related restrictions of the Flashplayer you have to place a crossdomain.xml to every website you want to load data from. The file should look something like this:
 
	<?xml version="1.0" ?>
	<cross-domain-policy>
		<allow-access-from domain="*" />
	</cross-domain-policy>
	
Maybe I can workaround this limitation in future versions. Maybe it is possible to fire the cross-domain calls via JavaScript and JSONP. 

## FAQ

### Why have you built this in Flash? Those times are over, aren't they?

I would never dare to write a screensaver without the amazing tweening engine TweenLite. And I wanted high performance blur effects on rotated text fields rendering beautiful embedded fonts. And I wanted this to run on any platform, including older Windows machines. After all, it was faster for me to code this is AS3. It's a fun project for me, you know?
