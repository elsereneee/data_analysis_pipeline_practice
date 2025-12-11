.SECONDARY:

# Default target: builds the final report
all: report/count_report.html

# 1. Rule to build the final report
# Depends on the source .qmd file and ALL 4 figure images being created first.
report/count_report.html: report/count_report.qmd results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	quarto render report/count_report.qmd

# 2. Pattern rule to create PNG figures from DAT files
results/figure/%.png: results/%.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=$< --output_file=$@

# 3. Pattern rule to create DAT files from raw TXT data
results/%.dat: data/%.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=$< --output_file=$@

# 4. Clean target to reset the analysis
# Removes all generated files so you can start fresh.
clean:
	rm -f results/*.dat
	rm -f results/figure/*.png
	rm -f report/count_report.html
	rm -rf report/count_report_files
