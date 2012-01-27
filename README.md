## Stock Option Price Chart Browser
**website:** http://optionben.heroku.com, not the latest version yet.

### Why this site?
Stock traders use stock charts all the time. There are lots of site to give you that. But there are not a lot of free sites that give you option price chart. While the chart itself might not allows you to place sure-win trades, at least it can teach you about what happened in the past and learn about the behavior of option prices. The only site I know that give you option chart is quotemedia.com. However, to see any one chart, you need to click on ten things to get to that chart and yes, you get a tiny chart that you can't do much about.

This site allows you to get to the chart in minimum clicks possible and allows you to customize the params of the chart like a breeze. 

Also, I am adding a utility that allow you to see the stock price ranking chart. For example, Apple could be No.10 in percentage price increase today among all US stocks. tomorrow it could be No.20. After that it could be No.1020. That would indicates Apple has been leading the market for two days and it then trails the market. This relative ranking can help you identify stocks that outperform/underperform the market in a set timeframe.
This feature is under development.

### Features
* User can set ticker, expiration date, strike price etc all at onces and see the chart immediately.
* Expiration date, strike prices are determined by the system intelligently.
* User can see relative percentage change ranking of each stocks to help them identify opportunities.


### Keywords
ajax, image-crawling, web request to extract data, cron jobs to process data and store the computation results.

### Implementation Notes
The option chart feature is basically a form that determines the full url to request. The returned image would be rendered on the page. However, because quotemedia prevents unauthorized image-linking. I am downloading the image first and then rendering the temp image. This would need the tmp folder on Heroku because Heroku does not allow download storage anywhere other than temp folder for a short period of time.

### Areas for Improvement
* better search.
* intelligent recommendation of best options to consider.
* allow user to log in and bookmark options and stock tickers.
 
