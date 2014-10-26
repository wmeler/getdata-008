=== CodeBook ===

All variables and functions have descriptive, meaningful names or comments. Read the source please.
Function names follow underscore notation, while variables use camel notation.
The job was quite easy as input had nice, read.table friendly format.
I've decided to filter columns before merging train an test sets because a lot of data is dropped, and less memory is needed.
load_data_set function does all filtering and joining job for each set. Output is simpy merged with rbind function.
Aggregation is done by aggregate function.
Every file name is build with functions. It's easy to change location of data sets, or add more data that follow naming conventions.
Script asumes that current workdir has contents of uci zip archive - "UCI HAR Dataset" subdirectory.
