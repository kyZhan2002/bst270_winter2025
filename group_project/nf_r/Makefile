# Variables
R_SCRIPT = Rscript
INPUT_FILES = ../data/29282-0001-Data.rda ../data/04652-0001-Data.rda
#INPUT_FILE2 = "../data/04652-0001-Data.rda"
FILTERED_FILE = make_results/preprocessed_data.csv
TABLE1_FILE = make_results/table1.csv
FIGURE1_FILE = make_results/figure1.png
#FIGURE1_FILES = $(addprefix figure1_, $(foreach t1, 1 2 3, $(foreach t2, 1 2 3, t1$(t1)_t2$(t2).png)))
TABLE2_FILE = make_results/table2.csv



# Default target
all: $(TABLE1_FILE) $(FIGURE1_FILE) $(TABLE2_FILE)

# Step 1: Filter the data
$(FILTERED_FILE): $(INPUT_FILES)  cli_preprocessing.r
	$(R_SCRIPT) cli_preprocessing.r $(INPUT_FILES) $(FILTERED_FILE)

# Step 2: Generate Table 1
$(TABLE1_FILE): $(FILTERED_FILE) cli_table1.r
	$(R_SCRIPT) cli_table1.r $(FILTERED_FILE) $(TABLE1_FILE)

# Step 3: Generate Figure 1
$(FIGURE1_FILE): $(FILTERED_FILE) cli_figure1.r
	$(R_SCRIPT) cli_figure1.r $(FILTERED_FILE) $(FIGURE1_FILE)

# Step 4: Generate Table 2
$(TABLE2_FILE): $(FILTERED_FILE) cli_table2.r
	$(R_SCRIPT) cli_table2.r $(FILTERED_FILE) $(TABLE2_FILE)

# Cleanup target
clean:
	rm -f $(FILTERED_FILE) $(TABLE1_FILE) $(FIGURE1_FILE) $(TABLE2_FILE)
