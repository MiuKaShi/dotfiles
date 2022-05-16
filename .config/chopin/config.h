/* See LICENSE file for copyright and license details. */
// config.def.h

/* Author: lorenzo */
/* E-mail: lorenzo<zetatez@icloud.com> */

#include <stdbool.h>
#include <stdlib.h>

struct KFV {
    const char *key;
    bool flag;
    const char *value;
};

struct KV {
    const char *key;
    const char *value;
};

/* open rules */
static const struct KFV open_map[] = {
    /* .ext  , &    , application        */
    {".djvu",  0, "zathura"          },
    {".epub",  1, "foliate"          },
    {".mobi",  0, "zathura"          },
    {".pdf",   0, "zathura"          },
    {".xmind", 0, "xmind"            },
    {".doc",   0, "wps"              },
    {".docx",  0, "wps"              },
    {".pptx",  0, "wpp"              },
    {".xls",   0, "gnumeric"         },
    {".xlsx",  0, "gnumeric"         },
    {".iso",   0, "atool --list --"  },
    {".cpio",  0, "atool --list --"  },
    {".pkg",   0, "atool --list --"  },
    {".gz",    0, "atool --list --"  },
    {".jar",   0, "atool --list --"  },
    {".tar",   0, "atool --list --"  },
    {".tgz",   0, "atool --list --"  },
    {".zip",   0, "atool --list --"  },
    {".rar",   0, "unrar -lt -p- --" },
    {".7z",    0, "7z l -p- --"      },
    {".json",  0, "nvim"             },
    {NULL,     0, NULL               }
};

/* open rules for rest */ // to get mime-type of a file: file --dereference --brief --mime-type filename
static const struct KFV open_else_map[] = {
    /*mime-type                                                                  , & , application                */
    {"application/epub+zip",                                                      1, "foliate"                  },
    {"application/json",                                                          0, "nvim"                     },
    {"application/msword",                                                        0, "wps"                      },
    {"application/ogg",                                                           0, "mpv"                      },
    {"application/pdf",                                                           0, "zathura"                  },
    {"application/vnd.ms-excel",                                                  0, "gnumeric"                 },
    {"application/vnd.ms-outlook",                                                0, "wps"                      },
    {"application/vnd.ms-powerpoint",                                             0, "wpp"                      },
    {"application/vnd.ms-project",                                                0, "wps"                      },
    {"application/vnd.openxmlformats-officedocument.presentationml.presentation", 0, "wpp"                      },
    {"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",         0, "gnumeric"                 },
    {"application/vnd.openxmlformats-officedocument.wordprocessingml.document",   0, "wps"                      },
    {"application/vnd.visio",                                                     0, "wps"                      },
    {"application/x-httpd-php",                                                   0, "nvim"                     },
    {"application/x-javascript",                                                  0, "nvim"                     },
    {"application/x-latex",                                                       0, "nvim"                     },
    {"application/x-sh",                                                          0, "nvim"                     },
    {"application/xhtml+xml",                                                     0, "nvim"                     },
    {"application/xml",                                                           0, "nvim"                     },
    {"application/bz",                                                            0, "atool --list --"          },
    {"application/bz2",                                                           0, "atool --list --"          },
    {"application/rar",                                                           0, "atool --list --"          },
    {"application/x-7z-compressed",                                               0, "atool --list --"          },
    {"application/x-cpio",                                                        0, "atool --list --"          },
    {"application/x-gzip",                                                        0, "atool --list --"          },
    {"application/x-hdf",                                                         0, "atool --list --"          },
    {"application/x-rar",                                                         0, "atool --list --"          },
    {"application/x-rar-compressed",                                              0, "atool --list --"          },
    {"application/x-tar",                                                         0, "atool --list --"          },
    {"application/zip",                                                           0, "atool --list --"          },
    {"audio/3gpp",                                                                0, "mpv"                      },
    {"audio/3gpp2",                                                               0, "mpv"                      },
    {"audio/acc",                                                                 0, "mpv"                      },
    {"audio/midi",                                                                0, "mpv"                      },
    {"audio/mpeg",                                                                0, "mpv"                      },
    {"audio/ogg",                                                                 0, "mpv"                      },
    {"audio/wav",                                                                 0, "mpv"                      },
    {"audio/wave",                                                                0, "mpv"                      },
    {"audio/webm",                                                                0, "mpv"                      },
    {"audio/x-m4a",                                                               0, "mpv"                      },
    {"audio/x-midi",                                                              0, "mpv"                      },
    {"audio/x-mpegurl",                                                           0, "mpv"                      },
    {"audio/x-msvideo",                                                           0, "mpv"                      },
    {"audio/x-pn-wav",                                                            0, "mpv"                      },
    {"audio/x-realaudio",                                                         0, "mpv"                      },
    {"audio/x-wav",                                                               0, "mpv"                      },
    {"video/3gpp",                                                                1, "mpv --geometry=100%x100%" },
    {"video/3gpp2",                                                               1, "mpv --geometry=100%x100%" },
    {"video/mp4",                                                                 1, "mpv --geometry=100%x100%" },
    {"video/ogg",                                                                 1, "mpv --geometry=100%x100%" },
    {"video/quicktime",                                                           1, "mpv --geometry=100%x100%" },
    {"video/webm",                                                                1, "mpv --geometry=100%x100%" },
    {"video/x-flv",                                                               1, "mpv --geometry=100%x100%" },
    {"video/x-m4v",                                                               1, "mpv --geometry=100%x100%" },
    {"video/x-matroska",                                                          1, "mpv --geometry=100%x100%" },
    {"video/x-ms-asf",                                                            1, "mpv --geometry=100%x100%" },
    {"video/x-ms-wmv",                                                            1, "mpv --geometry=100%x100%" },
    {"video/x-sgi-moive",                                                         1, "mpv --geometry=100%x100%" },
    {"image/bmp",                                                                 1, "nsxiv"                    },
    {"image/gif",                                                                 1, "nsxiv -a"                 },
    {"image/ief",                                                                 1, "nsxiv"                    },
    {"image/jpeg",                                                                1, "nsxiv"                    },
    {"image/pipeg",                                                               1, "nsxiv"                    },
    {"image/png",                                                                 1, "nsxiv"                    },
    {"image/svg+xml",                                                             1, "nsxiv"                    },
    {"image/tiff",                                                                1, "nsxiv"                    },
    {"image/webp",                                                                1, "nsxiv"                    },
    {"image/x-cmu-raster",                                                        1, "nsxiv"                    },
    {"image/x-cmx",                                                               1, "nsxiv"                    },
    {"image/x-icon",                                                              1, "nsxiv"                    },
    {"image/x-rgb",                                                               1, "nsxiv"                    },
    {"image/x-xbitmap",                                                           1, "nsxiv"                    },
    {"image/x-xpixmap",                                                           1, "nsxiv"                    },
    {"image/x-xwindowdump",                                                       1, "nsxiv"                    },
    {"inode/x-empty",                                                             0, "nvim"                     },
    {"text/calendar",                                                             0, "nvim"                     },
    {"text/css",                                                                  0, "nvim"                     },
    {"text/csv",                                                                  0, "nvim"                     },
    {"text/html",                                                                 0, "nvim"                     },
    {"text/javascript",                                                           0, "nvim"                     },
    {"text/plain",                                                                0, "nvim"                     },
    {"text/troff",                                                                0, "nvim"                     },
    {"text/x-c",                                                                  0, "nvim"                     },
    {"text/x-c++",                                                                0, "nvim"                     },
    {"text/x-java",                                                               0, "nvim"                     },
    {"text/x-makefile",                                                           0, "nvim"                     },
    {"text/x-ruby",                                                               0, "nvim"                     },
    {"text/x-script.python",                                                      0, "nvim"                     },
    {"text/x-tex",                                                                0, "nvim"                     },
    {"text/xml",                                                                  0, "nvim"                     },
    {"text/x-shellscript",                                                        0, "nvim"                     },
    {NULL,                                                                        0, NULL                       }
};

/* exec rules */
static const struct KV exec_map[] = {
    /*.ext   , shell scripts                                                                                                                          */
    {".c",     "filename=%s; cd ${filename%.*}; sh build.sh"                                                                                          },
    {".cpp",   "filename=%s; cd ${filename%.*}; sh build.sh"                                                                                          },
    {".go",    "filename=%s; go run ${filename}"                                                                                                      },
    {".java",  "filename=%s; cd ${filename%.*}; sh build.sh"                                                                                          },
    {".jl",    "filename=%s; julia ${filename}"                                                                                                       },
    {".js",    "filename=%s; node ${filename}"                                                                                                        },
    {".lua",   "filename=%s; lua ${filename}"                                                                                                         },
    {".py",    "filename=%s; python ${filename}"                                                                                                      },
    {".rb",    "filename=%s; ruby ${filename}"                                                                                                        },
    {".rs",    "filename=%s; cargo build && cargo run"                                                                                                },
    {".scala", "filename=%s; cd ${filename%.*}; sh build.sh"                                                                                          },
    {".sh",    "filename=%s; sh ${filename}"                                                                                                          },
    {".sql",   "filename=%s; mysql -uroot -p < ${filename}"                                                                                           },
    {".tex",   "filename=%s; xelatex -interaction nonstopmode ${filename}; bibtex *.aux; xelatex -interaction nonstopmode ${filename}; zathura *.pdf" },
    {".ts",    "filename=%s; tsc ${filename}"                                                                                                         },
    {NULL,     NULL                                                                                                                                   }
};

/* exec rules for rest */
static const struct KV exec_else_map[] = {
    /**   , shell scripts                  */
    {"*",  "filename=%s; sh ${filename }" },   // any excuteble file
    {NULL, NULL                           }
};

/* default options for cp, mv, rm */
static const char *cp_opt = "-fr"; // recommended "-ir"
static const char *mv_opt = "-f" ; // recommended "-i"
static const char *rm_opt = "-fr"; // recommended "-ir"
