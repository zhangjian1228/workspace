Using Twitter API, write a program that inspects CNN’s twitter account (https://twitter.com/cnn) by doing the following: 
1- Aggregate news/tweets posted on that account, by month and dump the aggregation results into a table. It’s sufficient to go back in time as far as 1st Of January 2016.

2- For each Tweet after 1st Of January 2016, expand it’s shortened URL (if it contained any), and store the Mapping in another table.

Bonus: Make this an HTTP service, where the user provides the twitter account that they want to do (1) on through a form, and their email address. When the results are ready, it will send them to the specified email address as a file (preferably a CSV file).

Notes: 

1. As the method can only return up to 3200 tweets. So this method cannot go back in time as far as 1st Jan 2016. (http://www.rubydoc.info/gems/twitter/Twitter/REST/Timelines#user_timeline-instance_method)

2. The SQlite3 database is used and to store the results.

3. The Bonus quesition has not been done yet.

4. You can use cloud9 development tool to clone the project and see the results directly.

