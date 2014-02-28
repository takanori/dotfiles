require 'irb/completion'
require 'pp'
require 'rubygems'
require 'readline'
require 'wirble'
# Readline.vi_editing_mode
IRB.conf[:SAVE_HISTORY] = 100_000
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

Wirble.init
Wirble.colorize
