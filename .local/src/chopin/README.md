chopin
![chopin](https://raw.githubusercontent.com/zetatez/chopin/main/.pics/chopin.gif)

# chopin
A cli tool that will greatly improve your working efficiency.

## Dependencies
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- vim
- ...

## Installation
```bash
git clone https://github.com/zetatez/chopin.git
cd chopin

## configure chopin if needed:
# vim config.def.h

## To install
sudo make clean install

## To uninstall
# sudo make uninstall
```

## Configuration
See [*config.def.h*](https://github.com/zetatez/chopin/blob/main/config.def.h)

HINTS:
- To get mime-type of a file:
    ```bash
    file --dereference --brief --mime-type filename
    ```

## Usage
```bash
chopin --help
    NAME
        chopin - A cli tool that greatly improves your work efficiency.
    SYNOPSIS
        chopin [-vhoecmr] file
    DESCRIPTION
        chopin is a tool for cli to open, exec, cp, mv, rm file automatically.
    OPTIONS
        -v     prints version information to cli and exit.
        -o     open a file with your default settings automatically.
        -e     exec a script with your default settings automatically.
        -c     copy a file.
        -m     move a file.
        -r     remove a file.
    CUSTOMIZATION
        chopin is customized by creating a custom config.h and recompiling the source code. This keeps it fast, secure and simple.
    BUGS
        Send all bug reports with a patch to zetatez@icloud.com.
```

## Best Practice

              dwm/shell key binding -> [fd  ->  fzf ->  chopin]

- Use chopin in dwm:
    ```c
    #define SUPKEY Mod4Mask
    #define TM(cmd)    { "st", "-e", "/bin/sh", "-c", cmd, NULL }

    static const char *chopin_open[]       = TM("fd --type f --hidden --exclude .git . '/home/lorenzo'|fzf --prompt='open>' --preview 'bat --color=always {}' --select-1 --exit-0|xargs chopin -o {}");
    static const char *chopin_copy[]       = TM("chopin -c \"$(fd --type f --hidden --exclude .git . '/home/lorenzo'|fzf --prompt='copy>'  --preview 'bat --color=always {}' --select-1 --exit-0)\"");
    static const char *chopin_move[]       = TM("chopin -m \"$(fd --type f --hidden --exclude .git . '/home/lorenzo'|fzf --prompt='move>' --preview 'bat --color=always {}' --select-1 --exit-0)\"");
    static const char *chopin_exec[]       = TM("fd -e sh -e jl -e py -e tex -e c -e cpp -e go -e scala -e java -e rs -e sql --exclude .git . '/home/lorenzo'|fzf --prompt='exec>'  --preview 'bat --color=always {}' --select-1 --exit-0|xargs chopin -e {}");
    static const char *chopin_remove[]     = TM("chopin -r \"$(fd --type f --hidden --exclude .git . '/home/lorenzo'|fzf --prompt='remove>' --preview 'bat --color=always {}' --select-1 --exit-0)\"");
    static const char *chopin_open_media[] = TM("fd -e jpg -e jpeg -e png -e gif -e bmp -e tiff -e mp3 -e flac -e mkv -e avi -e mp4 --exclude .git . '/home/lorenzo/'|fzf --prompt='medias>' --reverse --select-1 --exit-0|xargs chopin -o {}");
    static const char *chopin_open_book[]  = TM("fd -e pdf -e epub -e djvu -e mobi --exclude .git . '/home/lorenzo/obsidian/docs/'|fzf --prompt='books>' --reverse --select-1 --exit-0|xargs chopin -o {}");
    static const char *chopin_open_wiki[]  = TM("fd --type f --hidden --exclude .git . '/home/lorenzo/obsidian/wiki/'|fzf --prompt='wikis>' --preview 'bat --color=always {}' --select-1 --exit-0|xargs chopin -o {}");

	static Key keys[] = {
		// ...
        { SUPKEY,                       XK_f,          spawn,             {.v = chopin_open       } },
        { SUPKEY,                       XK_n,          spawn,             {.v = chopin_copy       } },
        { SUPKEY,                       XK_v,          spawn,             {.v = chopin_move       } },
        { SUPKEY,                       XK_x,          spawn,             {.v = chopin_exec       } },
        { SUPKEY,                       XK_z,          spawn,             {.v = chopin_remove     } },
        { SUPKEY,                       XK_a,          spawn,             {.v = chopin_open_media } },
        { SUPKEY,                       XK_p,          spawn,             {.v = chopin_open_book  } },
        { SUPKEY,                       XK_w,          spawn,             {.v = chopin_open_wiki  } },
		// ...
	};
    ```


- Use chopin in zsh:
    ```zsh
    # chopin
    alias chopin-open="fd --type f --hidden --exclude .git . './'|fzf --prompt='open>' --preview 'bat --color=always {}' --select-1 --exit-0|xargs chopin -o {}"
    alias chopin-exec="fd -e sh -e jl -e py -e tex -e c -e cpp -e go -e scala -e java -e rs -e sql --exclude .git . './'|fzf --prompt='exec>'  --preview 'bat --color=always {}' --select-1 --exit-0|xargs chopin -e {}"
    alias chopin-copy="chopin -c \"\$(fd --type f --hidden --exclude .git . './'|fzf --prompt='copy>'  --preview 'bat --color=always {}' --select-1 --exit-0)\""
    alias chopin-move="chopin -m \"\$(fd --type f --hidden --exclude .git . './'|fzf --prompt='move>' --preview 'bat --color=always {}' --select-1 --exit-0)\""
    alias chopin-remove="chopin -r \"\$(fd --type f --hidden --exclude .git . './'|fzf --prompt='remove>' --preview 'bat --color=always {}' --select-1 --exit-0)\""
    alias chopin-open-wiki="fd --type f --hidden --exclude .git . '$HOME/wiki'|fzf --prompt='wikis>' --preview 'bat --color=always {}' --select-1 --exit-0|xargs chopin -o {}"
    alias chopin-open-book="fd -e pdf -e epub -e djvu -e mobi --exclude .git . '$HOME/docs'|fzf --prompt='books>' --reverse --select-1 --exit-0|xargs chopin -o {}"
    alias chopin-open-media="fd -e jpg -e jpeg -e png -e gif -e bmp -e tiff -e mp3 -e flac -e mkv -e avi -e mp4 --exclude .git . '$HOME'|fzf --prompt='medias>' --reverse --select-1 --exit-0|xargs chopin -o {}"

    bindkey -s '^F' 'chopin-open\n'
    bindkey -s '^X' 'chopin-exec\n'
    bindkey -s "^N" 'chopin-copy\n'
    bindkey -s "^V" 'chopin-move\n'
    bindkey -s "^Z" 'chopin-remove\n'
    bindkey -s '^W' 'chopin-open-wiki\n'
    bindkey -s '^P' 'chopin-open-book\n'
    bindkey -s '^A' 'chopin-open-media\n'
    ```

## LICENSE

MIT.
