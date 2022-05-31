# Keym

This is a tool for controlling the mouse smoothly with the keyboard. It supports five speed settings with fast scrolling and responsive updates. A selection of keys get unmapped while the application is running. This lets you still use other keys not used by the tool, rather than naively grabbing the entire keyboard. However, if you still want the application to fully grab all the keyboard you can press `Right Control` to do this.

## Installation

Install either from the makefile or compile with gcc:

`gcc keym.c -lX11 -lXtst -o keym`

## Usage

- `HJKL` to move
- `N/A` to click
- `M/S` to right click
- `I/W` to middle click
- `U/D` to scroll

- `R` for the browser back button
- `F` for the browser forward button.

- Hold `Z` to move extremely quickly
- Hold `left shift/;` to move quickly,
- Hold `X` and `\` or `Tab Key` to move slowly.
- Hold `C` to move very slowly,

- Exit with `q` or `Esc`.

## Help wanted / known issue

Some applications, like `code`, do their own input handling - so typing still happens even though the keys have been unmapped. While you can press `Right Control`, calling `XGrabKeyboard` to take the focus away, this cause issues in other applications, e.g. gtk2 menus in `pcmanfm` wont register, as the focus will be lost. Solving this in a stable way, while working for all applications and allowing you to use other keys while `keym` is used, is non-trivial. Any suggestions/improvement relating to this challenge, please let me know.
