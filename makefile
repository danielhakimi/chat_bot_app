# Makefile for running build_runner

.PHONY: br

# Command to run build_runner
br:
	dart run build_runner build -d
