all: clean build run

# Build all the examples
build:
	@./bin/do_all.sh build

# Execute all the examples
run:
	@./bin/do_all.sh run

# Clean up all the examples
clean:
	@./bin/do_all.sh clean

# Print a list of all the examples
list:
	@./bin/list.sh -x
