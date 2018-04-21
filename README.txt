To reproduce benchmarking results, perform the following steps:

Each one of our proposed solutions is stored in a seperate folder 
and that folder contains a "testbench.vhd" file. The folder also contains
the text files containing machine code for our 3 implemented test cases:
"testcase1.txt" : No Branching
"testcase2.txt" : Branch Always Taken
"testcase3.txt" : Alternating Branch Taken/Not-Taken

In order to recreate our benchmarks, simply go to line # in the 
"testbench.vhd" file and replace the name of the file to open
with the name of the test case you wish to observe.

The next step is to run the "testbench.tcl" file.
The processor begins to run at the second clock cycle rising edge after the "reset" has been set to 1 and then set to 0.
The processor ends as soon as the "IR" signal becomes 0 for the remainder of the simulator run.
We can calculate the runtime of the processor by subtracting the start time from the end time.
To obtain the number of clock cycles, simply divide the runtime by 2 ns, which is the size of a clock cycle.


Disclaimer: Unfortunately, we ran into some trouble in regards to flush request and data forwarding for the early branch
	    resolution. Because of this, we could only implement the easier prediction scheme - branch not taken.