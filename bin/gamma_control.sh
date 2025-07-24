#!/usr/bin/env bash

# Display Gamma Control Script
# Controls display gamma based on time of day with caching mechanism

set -euo pipefail  # Exit on error, undefined variables, and pipe failures

# Configuration
CACHE_FILE="/tmp/display-gamma-cache"
NIGHT_SCRIPT="$HOME/bin/night-display"
MORNING_SCRIPT="$HOME/bin/morning-display"
DAY_SCRIPT="$HOME/bin/day-display"

# Time ranges in HHMM format for easier comparison
NIGHT_START="1946"    # 7:46 PM
NIGHT_END="0445"      # 4:45 AM
MORNING_START="0446"  # 4:46 AM
MORNING_END="0745"    # 7:45 AM

# Function to convert timestamp to HHMM format for period determination
get_current_time() {
    date '+%H%M'
}

# Function to determine time period based on current time
get_time_period() {
    local current_time
    current_time=$(get_current_time)

    # Night time: 19:46 to 04:45 (crosses midnight)
    if [[ "$current_time" -ge "$NIGHT_START" ]] || [[ "$current_time" -le "$NIGHT_END" ]]; then
        echo "night"
    # Morning time: 04:46 to 07:45
    elif [[ "$current_time" -ge "$MORNING_START" ]] && [[ "$current_time" -le "$MORNING_END" ]]; then
        echo "morning"
    # Day time: remainder
    else
        echo "day"
    fi
}

# Function to check if cache file exists and period matches
is_cache_valid() {
    local current_period="$1"

    # Quick exit if cache file doesn't exist
    [[ -f "$CACHE_FILE" ]] || return 1

    # Check if period matches
    local cached_period
    cached_period=$(head -n 1 "$CACHE_FILE" 2>/dev/null) || return 1

    # Check if cached period matches current period
    [[ "$cached_period" == "$current_period" ]]
}

# Function to update cache file
update_cache() {
    local period="$1"

    # Store period in cache
    echo "$period" > "$CACHE_FILE"
}

# Function to execute appropriate display script
execute_display_script() {
    local period="$1"
    local script_path=""

    case "$period" in
        "night")
            script_path="$NIGHT_SCRIPT"
            ;;
        "morning")
            script_path="$MORNING_SCRIPT"
            ;;
        "day")
            script_path="$DAY_SCRIPT"
            ;;
        *)
            echo "Error: Unknown time period '$period'" >&2
            return 1
            ;;
    esac

    # Check if script exists and is executable
    if [[ ! -x "$script_path" ]]; then
        echo "Error: Script '$script_path' not found or not executable" >&2
        return 1
    fi

    # Execute the script
    echo "Executing $script_path for $period time period"
    "$script_path"
}

# Function to update display gamma when cache is invalid
update_display_gamma() {
    local current_period="$1"

    echo "Cache invalid or expired, updating for $current_period period"

    # Update cache before executing script
    update_cache "$current_period"

    # Execute the appropriate display script
    execute_display_script "$current_period"
}

# Main execution function
main() {
    # Get current period once
    local current_period
    current_period=$(get_time_period)

    # Fast cache validation - exits early if cache is valid
    if is_cache_valid "$current_period"; then
        echo "Cache is valid, no action needed"
        return 0
    fi

    # Cache is invalid, update display gamma
    update_display_gamma "$current_period"
}

# Time period mapping table for reference
show_time_periods() {
    cat << EOF
Time Period Mappings:
┌─────────────┬─────────────┬─────────────────┐
│ Period      │ Start Time  │ End Time        │
├─────────────┼─────────────┼─────────────────┤
│ Night       │ 19:46       │ 04:45 (next day)│
│ Morning     │ 04:46       │ 07:45           │
│ Day         │ 07:46       │ 19:45           │
└─────────────┴─────────────┴─────────────────┘

Scripts:
- Night: $NIGHT_SCRIPT
- Morning: $MORNING_SCRIPT
- Day: $DAY_SCRIPT

Cache: $CACHE_FILE (period-based validation)
EOF
}

# Handle command line arguments
first_arg="${1:-}"
case "$first_arg" in
    "--help"|"-h")
        echo "Usage: $0 [--help|--show-periods]"
        echo "Controls display gamma based on time of day with caching"
        echo ""
        echo "Options:"
        echo "  --help, -h        Show this help message"
        echo "  --show-periods    Show time period mappings"
        ;;
    "--show-periods")
        show_time_periods
        ;;
    "")
        main
        ;;
    *)
        echo "Error: Unknown option '$first_arg'" >&2
        echo "Use --help for usage information" >&2
        exit 1
        ;;
esac
