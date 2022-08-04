/* See LICENSE file for copyright and license details. */
// config.def.h

/* Author: lorenzo */
/* E-mail: lorenzo<zetatez@icloud.com> */

static const struct OpenRule open_rules[] = {
    {"inode/x-empty",        "nvim",    0},
    {"text/plain",           "nvim",    0},
    {"application/pdf",      "zathura", 0},
    {"application/epub+zip", "foliate", 0},
    {"application/json",     "nvim",    0},
    {"text/x-shellscript",   "nvim",    0},
    {"text/x-c",             "nvim",    0},
    {"text/x-c++",           "nvim",    0},
    {"text/x-java",          "nvim",    0},
    {"text/x-makefile",      "nvim",    0},
    {"text/x-ruby",          "nvim",    0},
    {"text/x-script.python", "nvim",    0},
    {"text/x-tex",           "nvim",    0},
    {"text/x-diff",          "nvim",    0},
    {"text/csv",             "nvim",    0},
    {"text/html",            "nvim",    0},
    {"text/javascript",      "nvim",    0},
    {"text/troff",           "nvim",    0},
    {"text/xml",             "nvim",    0},
    {"text/css",             "nvim",    0},
    /* {"text/calendar",                                                          "nvim"                      ,0}, */
    {"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",         "libreoffice", 0},
    {"application/vnd.openxmlformats-officedocument.wordprocessingml.document",   "libreoffice", 0},
    {"application/vnd.openxmlformats-officedocument.presentationml.presentation", "libreoffice", 0},
    {"application/msword",                                                        "libreoffice", 0},
    {"application/vnd.ms-excel",                                                  "libreoffice", 0},
    {"application/vnd.ms-outlook",                                                "libreoffice", 0},
    {"application/vnd.ms-powerpoint",                                             "libreoffice", 0},
    /* {"application/vnd.ms-project",                                             "libreoffice"              ,0}, */
    /* {"application/vnd.visio",                                                  "libreoffice"              ,0}, */
    /* {"application/x-httpd-php",                                                "nvim"                      ,0}, */
    {"application/x-javascript",                                                  "nvim", 0},
    {"application/x-sh",                                                          "nvim", 0},
    {"application/x-latex",                                                       "nvim", 0},
    {"application/xml",                                                           "nvim", 0},
    {"application/xhtml+xml",                                                     "nvim", 0},
    {"image/jpg",                                                                 "nsxiv", 0},                             // jpg    // nsxiv, feh, img2txt --gamma=0.5
    {"image/jpeg",                                                                "nsxiv", 0},                            // jpeg   // nsxiv, feh, img2txt --gamma=0.5
    {"image/png",                                                                 "nsxiv", 0},                             // png    // nsxiv, feh, img2txt --gamma=0.5
    {"image/gif",                                                                 "nsxiv -a", 0},                          // gif    // nsxiv, feh, img2txt --gamma=0.5
    {"audio/acc",                                                                 "mpv", 0},                              // acc
    {"audio/mpeg",                                                                "mpv", 0},                             // mp2, mp3, mpeg
    {"audio/wav",                                                                 "mpv", 0},                              // wav
    {"video/mp4",                                                                 "mpv --geometry=100%x100%", 0},         // mp4
    {"video/x-flv",                                                               "mpv --geometry=100%x100%", 0},       // flv
    {"video/x-msvideo",                                                           "mpv --geometry=100%x100%", 0},   // avi
    /* {"video/quicktime"                                                           ,"mpv --geometry=100%x100%" ,0}, // quicktime */
    /* {"video/webm"                                                                ,"mpv --geometry=100%x100%" ,0}, // weba, webm */
    {"application/x-tar", "atool --list --", 0},                                                                  // tar
    {"application/zip", "atool --list --", 0},                                                                    // zip
    {"application/x-gzip", "atool --list --", 0},                                                                 // gz
    {"application/rar", "atool --list --", 0},                                                                    // rar
    {"application/x-7z-compressed", "atool --list --", 0},                                                        // 7z
    /* {"application/x-bz"                                                          ,"atool --list --"          ,0}, // bz */
    /* {"application/x-bz2"                                                         ,"atool --list --"          ,0}, // bz2 */
    {"application/x-rar", "atool --list --", 0},                                                                  // rar
    {"application/x-rar-compressed", "atool --list --", 0},                                                       // rar
    /* {"application/x-cpio"                                                        ,"atool --list --"          ,0}, // cpio */
    {"application/java-archive", "atool --list --", 0},                                                           // java-archive
};

static const struct ExecRule exec_rules[] = {
    {"c", "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {"cpp", "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {"go", "file_name=%s; go run ${file_name}"                                                                                                       },
    {"java", "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {"jl", "file_name=%s; julia ${file_name}"                                                                                                        },
    {"js", "file_name=%s; node ${file_name}"                                                                                                         },
    {"lua", "file_name=%s; lua ${file_name}"                                                                                                          },
    {"py", "file_name=%s; python ${file_name}"                                                                                                       },
    {"rb", "file_name=%s; ruby ${file_name}"                                                                                                         },
    {"rs", "file_name=%s; cargo build && cargo run"                                                                                                  },
    {"scala", "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {"sh", "file_name=%s; sh ${file_name}"                                                                                                           },
    {"sql", "file_name=%s; mysql -uroot -p < ${file_name}"                                                                                            },
    {"tex", "file_name=%s; xelatex -interaction nonstopmode ${file_name}; bibtex *.aux; xelatex -interaction nonstopmode ${file_name}; zathura *.pdf" },
    {"ts", "file_name=%s; tsc ${file_name}"                                                                                                          },
};

static const char *copy_opt = "-rf";
static const char *move_opt = "-f" ;
static const char *remove_opt = "-rf";
