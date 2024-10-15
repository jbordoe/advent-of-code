#!/bin/sh

USAGE='Downloads your given Advent of Code input for the given day and year
AOC_SESSION_COOKIE must be set (will be set in your browser after successful login)
Usage:
  load_input.sh --day 1 --year 2023
';

usage() {
  log "${USAGE}";
}

log() { echo "$1" 1>&2; }
error() { log "\033[1;31m$1\033[0m"; }
warn() { log "\033[0;33m$1\033[0m"; }
info() { log "\033[0;34m$1\033[0m"; }
success() { log "\033[1;32m$1\033[0m"; }

# Parse command-line arguments
while [ "$#" -gt 0 ]; do
  case $1 in
    --year) year="$2"; shift ;;
    --day)  day="$2";  shift ;;
    *) error "Unknown parameter passed: $1"; usage && exit 1 ;;
  esac
  shift
done

# Check if day and year are set and non-empty
[ -z "$day" ]  && { log -e "\033[1;31mMissing required param: day\033[0m"; usage && exit 1; }
[ -z "$year" ] && { log -e "\033[1;31mMissing required param: year\033[0m"; usage && exit 1; }

repo_root=$(git rev-parse --show-toplevel)
local_input_dir="$repo_root/priv/input/$year";
local_input_path="${local_input_dir}/day_${day}.txt";

if [ -f "${local_input_path}" ]; then
  warn "$local_input_path already present, halting.";
  exit 1
fi

if [ -z "$AOC_SESSION_COOKIE" ]; then
  # Print "not found" in bold red and exit
  log -e "\033[1;31mAOC_SESSION_COOKIE is not set, please log in and save the session cookie to proceed. Alternativly you can save the input data yourself under ${local_input_path}\033[0m"
  exit 1
fi

# Print "found" in bold green
log -e "\033[1;32mSession cookie present.\033[0m"

# example: https://adventofcode.com/2022/day/1
input_url="https://adventofcode.com/${year}/day/${day}/input";
info "Fetching input from ${input_url} ...";

# Make the curl request and capture the response and HTTP status code
response=$(curl -s -w "%{http_code}" -o /tmp/aoc_curl_response.txt --cookie "session=${AOC_SESSION_COOKIE}" "$input_url");

# Check if the HTTP status code is 200
if [ "$response" -ne 200 ]; then
    error "failed, got $response" 1>&2;
else
    mkdir -p $local_input_dir; 
    mv /tmp/aoc_curl_response.txt $local_input_path \
    && success "Saved input to ${local_input_path}";
fi
