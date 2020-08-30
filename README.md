# fishblocks
A dead simple fishshell prompt.

| Fishblocks Preview |
| --- |
| [Preview](fishblock.gif) |

## Dependencies

+ `fish > 3.1.0`
+ A nerd font. `MesloLGS NF` is recommended.

## Usage

+ Install the dependencies.
+ Clone this repository.
+ Copy `fish_prompt.fish` to `/PATH/TO/FISH/CONFIG/functions/`

## Features

+ Shows incognito icon if in private mode.
+ SSH display.
+ Git display with color coding.
+ Previous command status display.
+ Dynamic background color for time display.
+ OS/Distribution icon display. (Tested only on Archlinux. Feedbacks welcome!)

## Extras

The colors may vary due to the difference of our terminal colors. Here's mine if you want it:

<details><summary>Click here to show colors</summary>
<p>

```
# Black
color10		#3D4C5F
color8			#56687E

# Red
color1			#EE4F84
color9			#F48FB1

# Green
color2			#53E2AE
color10		#A1EFD3

# Yellow
color3			#F1FF52
color11		#F1FA8C

# Blue
color4			#6498EF
color12		#92B6F4

# Magenta
color5			#985EFF
color13		#BD99FF

# Cyan
color6			#24D1E7
color14		#87DFEB

# White
color7			#E5E5E5
color15		#F8F8F2
```

</p>
</details>

## TODOs

The roadmap for this project. PRs are welcome!

+ [ ] Test OS/Distribution icon display on different distros and platforms.
+ [ ] Improve Git display.
+ [ ] Refactor/Modularized fish prompt script.
+ [ ] Oh My Fish.

## Contribute

Fork the project, do some improvement or modifications, then feel free to submit a pull request! Bug reports are also welcome!
