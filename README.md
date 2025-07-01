# Foreman migrate to SCA
Migrate Foreman from a non SCA to SCA enabled Org

## Background
When we upgraded to Foreman 3.4 & Katello 4.6 and enabled SCA we got the problem that ALL our servers had ALL repos enabled.

To quickly fix the issue we disabled SCA to investigate.

## Solution
The solution we came up with was this script: `generate_hammer_commands.sh`

## How to
Make sure you have following packages installed

- jq
- hammer-cli

1. Disable SCA 
2. Run the script: `bash generate_hammer_commands.sh`
3. Enable SCA
4. Up to Foreman 3.7 enabling SCA made Foreman enable all repos on all servers by default this was fixed in [Foreman 3.7 #36301](https://projects.theforeman.org/issues/36301)
   - If all your servers have all repos enabled you can disable them by doing a bulk edit using webui Hosts > Content Host > Select all hosts > Use Dropdown Select Action > Manage Repository sets > Mark all repos > Reset do default.
   - If all your repos are already disabled you can skip this step and go to 5. 
5. Run the new file created: `bash hammer_commands.txt`. It will make use of hammer cli to enable all repos on that was enabled before SCA was enabled on each server. 
