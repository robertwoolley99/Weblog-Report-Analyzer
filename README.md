## Approach.   
In terms of building this I followed strict TDD. However because I did it over two days I had the benefit of my brain working overnight which will be evident in some of the refactoring - cleaning code up and using Ruby methods rather grokking large amounts of code.

## Installation
Clone the github repo to your local machine with `git clone https://github.com/robertwoolley99/Weblog-Report-Analyzer.git`

Then run `bundle install` to ensure you have the relevant gems.

## Tests and Coverage.
The program is built in Ruby using Rspec for testing and Simplecov for 100% test coverage.

## Quick Start
1. Require all three files in the lib directory.
2. Create a new instance of the Weblog object thus:  ```injection = Weblog.new(filename)``` If no filename is specified then Weblog will default to 'webserver.log'
3. Create a new instance of the Analyzer object and pass in the Weblog instance thus:  ```analyzer = Analyzer.new(injection)```
4. Then create a new instance of the OutputWriter object, passing in Analyzer thus:  ```output = OutputWriter.new(analyzer)```
5. To generate a Unique Views report, with output to ```unique_views.txt``` file run ```output.uv_report```
6. To generate a Non Unique Views report, with output to: `non_unique_views.txt` file run `output.nuv_report`.


## Architecture.
There are three objects in play:


### Weblog  
It has only one method - initialize which does the following:  
a) Opens a file (defaults to 'webserver.log' if no filename supplied).  
b) Parses the file on a line by line basis.   
c) Chomps the newline for each line.  
d) For each line, splits between the URL and the IP address - puts them into an array output.   
e) Pushes output into a 2D array, @data, which can be read from other objects.   
f) Closes the file.  

### Analyzer.  
This does the main task of crunching the data.  When an instance is spawned it requires an instance of Weblog to be passed in.  In addition, the Initialize method calls the following methods:   
a) Builds Dictionary.  
b) Runs the Non_ Unique_ Count method.   
c) Runs the Unique_ Count method.

 Analyzer - Build Dictionary Method.  
 The Dictionary is a non-duplicated list of the urls in the weblog, held in an array.  This method first takes @data (the Weblog object).  It then iterates through the array and copies 0 and even numbered elements (URLs) to an array.  Finally it calls the .uniq method which removes duplicates and creates @dictionary.

 Analyzer - Non Unique Count Method.  
 This builds a 2D array which is a report of URLs with a count of all accesses to a URL.  It does this by iterating through the Dictionary array - then asking the @data array how many times a URL appears; it then pushes to the 2D array, xnuc, an array of the URL and the count.  Finally it calls reverse sort to create @nuc which has the URLs with the most hits at the top.

 Analyzer - Unique Count Method.  
 This builds a 2D array which is a report of URLs with count of unique accesses.  Like its Non Unique sister, it iterates through the dictionary. On an iteration it calls url_ ip_ match method, passing in the URL.  Url_ ip_ match returns a 1D array of all the ip addresses (which includes duplicate). UCM then passes this to the ip_ count method.  ip_ count method runs the uniq method to remove duplicate ip addresses, and returns the total number of unique IP addresses.  Finally, Unique Count Method pushes an array to a 2D array of a URL and the number of unique IP addresses associated with that URL.
 Finally, the 2D array is sorted in descending order creating @uc.

###  Output Writer.   
This takes the arrays from Analyzer, formats them and writes them to seperate files.  The initialize method has a dependency on an Analyzer object.  It then creates two instance variables - @uv which maps to the Unique Count array in Analyzer and @nuv which is the Non-Unique Count in Analyzer.

Output Writer - nuv_ report.   
Creates a Non Unique Views report (we use views rather than counts in Output_ writer to clarify matters).  Nuv_ report writes a title to a variable.  It then calls the build_ report method (detailed below) and writes the output to the non_ unique_ views.txt file.

Output Writer - uv_ report.   
Creates a Unique Views report - as NUV.

Output Writer - build_ report
This takes the relevant uv/nuv array and iterates through it, outputting URL, tab separators and number of view to a variable.  This is returned to the calling method which writes it to the relevant file.   

Output Writer - tab_ string
This works out whether one or two tabs are required between a URL and a number of views depnding on the URL length.
