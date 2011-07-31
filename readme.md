
Simple Datavis Screensaver
==========================

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
