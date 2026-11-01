# dash: big empty shell on the left; on the right, an empty shell with a thin
# cmatrix strip beside it, above fastfetch.
#
#   +-----------+--------+--+
#   |           |        |cm|
#   |           +--------+--+
#   |           |fastfetch  |
#   +-----------+-----------+
#
# Run by `tlayout dash`, which first opens a fresh window (or session) with one
# pane, so this file only splits it. Sizes are percentages so the layout scales
# to any window. Commands go in with send-keys rather than as the pane command,
# so quitting one leaves its shell open instead of closing the pane.

split-window -h -l 47%
split-window -v -l 40%
send-keys 'fastfetch' Enter
select-pane -U
split-window -h -l 14%
send-keys 'cmatrix' Enter
select-pane -t '{top-left}'
