/* See LICENSE file for copyright and license details. */
// config.def.h

/* Author: lorenzo */
/* E-mail: lorenzo<zetatez@icloud.com> */

/* open rules */
static const struct KFV open_map[] = {
    /* .ext  , &    , application        */
    {".djvu", 0, "evince"           },
    {".epub", 0, "foliate"          },
    {".mobi", 0, "okular"           },
    {".pdf",  0, "zathura"          },
    {".doc",  0, "libreoffice"      },
    {".docx", 0, "libreoffice"      },
    {".pptx", 0, "libreoffice"      },
    {".xls",  0, "libreoffice"      },
    {".xlsx", 0, "libreoffice"      },
    {".iso",  0, "atool --list --"  },
    {".cpio", 0, "atool --list --"  },
    {".pkg",  0, "atool --list --"  },
    {".gz",   0, "atool --list --"  },
    {".jar",  0, "atool --list --"  },
    {".tar",  0, "atool --list --"  },
    {".tgz",  0, "atool --list --"  },
    {".zip",  0, "atool --list --"  },
    {".rar",  0, "unrar -lt -p- --" },
    {".7z",   0, "7z l -p- --"      },
};

/* open rules for rest */ // Note: to get mime-type of a file: file --dereference --brief --mime-type file_name
static const struct KFV open_map_else[] = {
    /*mime-type                                                                  , & , application                */
    {"application/epub+zip",                                                      0, "foliate"                  },
    {"application/json",                                                          0, "nvim"                      },
    {"application/msword",                                                        0, "libreoffice"              },
    {"application/ogg",                                                           0, "mpv"                      },
    {"application/pdf",                                                           0, "zathura"                  },
    {"application/vnd.ms-excel",                                                  0, "libreoffice"              },
    {"application/vnd.ms-outlook",                                                0, "libreoffice"              },
    {"application/vnd.ms-powerpoint",                                             0, "libreoffice"              },
    {"application/vnd.ms-project",                                                0, "libreoffice"              },
    {"application/vnd.openxmlformats-officedocument.presentationml.presentation", 0, "libreoffice"              },
    {"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",         0, "libreoffice"              },
    {"application/vnd.openxmlformats-officedocument.wordprocessingml.document",   0, "libreoffice"              },
    {"application/vnd.visio",                                                     0, "libreoffice"              },
    {"application/x-httpd-php",                                                   0, "nvim"                      },
    {"application/x-javascript",                                                  0, "nvim"                      },
    {"application/x-latex",                                                       0, "nvim"                      },
    {"application/x-sh",                                                          0, "nvim"                      },
    {"application/xhtml+xml",                                                     0, "nvim"                      },
    {"application/xml",                                                           0, "nvim"                      },
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
    {"video/3gpp",                                                                0, "mpv --geometry=100%x100%" },
    {"video/3gpp2",                                                               0, "mpv --geometry=100%x100%" },
    {"video/mp4",                                                                 0, "mpv --geometry=100%x100%" },
    {"video/ogg",                                                                 0, "mpv --geometry=100%x100%" },
    {"video/quicktime",                                                           0, "mpv --geometry=100%x100%" },
    {"video/webm",                                                                0, "mpv --geometry=100%x100%" },
    {"video/x-flv",                                                               0, "mpv --geometry=100%x100%" },
    {"video/x-m4v",                                                               0, "mpv --geometry=100%x100%" },
    {"video/x-matroska",                                                          0, "mpv --geometry=100%x100%" },
    {"video/x-ms-asf",                                                            0, "mpv --geometry=100%x100%" },
    {"video/x-ms-wmv",                                                            0, "mpv --geometry=100%x100%" },
    {"video/x-sgi-moive",                                                         0, "mpv --geometry=100%x100%" },
    {"image/bmp",                                                                 0, "nsxiv"                     },
    {"image/gif",                                                                 0, "nsxiv -a"                  },
    {"image/ief",                                                                 0, "nsxiv"                     },
    {"image/jpg",                                                                 0, "nsxiv"                     },
    {"image/jpeg",                                                                0, "nsxiv"                     },
    {"image/pipeg",                                                               0, "nsxiv"                     },
    {"image/png",                                                                 0, "nsxiv"                     },
    {"image/svg+xml",                                                             0, "nsxiv"                     },
    {"image/tiff",                                                                0, "nsxiv"                     },
    {"image/webp",                                                                0, "nsxiv"                     },
    {"image/x-cmu-raster",                                                        0, "nsxiv"                     },
    {"image/x-cmx",                                                               0, "nsxiv"                     },
    {"image/x-icon",                                                              0, "nsxiv"                     },
    {"image/x-rgb",                                                               0, "nsxiv"                     },
    {"image/x-xbitmap",                                                           0, "nsxiv"                     },
    {"image/x-xpixmap",                                                           0, "nsxiv"                     },
    {"image/x-xwindowdump",                                                       0, "nsxiv"                     },
    {"inode/x-empty",                                                             0, "nvim"                      },
    {"text/calendar",                                                             0, "nvim"                      },
    {"text/css",                                                                  0, "nvim"                      },
    {"text/csv",                                                                  0, "nvim"                      },
    {"text/html",                                                                 0, "nvim"                      },
    {"text/javascript",                                                           0, "nvim"                      },
    {"text/plain",                                                                0, "nvim"                      },
    {"text/troff",                                                                0, "nvim"                      },
    {"text/x-shellscript",                                                        0, "nvim"                      },
    {"text/x-c",                                                                  0, "nvim"                      },
    {"text/x-c++",                                                                0, "nvim"                      },
    {"text/x-java",                                                               0, "nvim"                      },
    {"text/x-makefile",                                                           0, "nvim"                      },
    {"text/x-ruby",                                                               0, "nvim"                      },
    {"text/x-script.python",                                                      0, "nvim"                      },
    {"text/x-tex",                                                                0, "nvim"                      },
    {"text/x-diff",                                                               0, "nvim"                      },
    {"text/xml",                                                                  0, "nvim"                      },
};

/* exec rules */
static const struct KV exec_map[] = {
    /*.ext   , shell scripts                                                                                                                            */
    {".c",     "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {".cpp",   "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {".go",    "file_name=%s; go run ${file_name}"                                                                                                       },
    {".java",  "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {".jl",    "file_name=%s; julia ${file_name}"                                                                                                        },
    {".js",    "file_name=%s; node ${file_name}"                                                                                                         },
    {".lua",   "file_name=%s; lua ${file_name}"                                                                                                          },
    {".py",    "file_name=%s; python ${file_name}"                                                                                                       },
    {".rb",    "file_name=%s; ruby ${file_name}"                                                                                                         },
    {".rs",    "file_name=%s; cargo build && cargo run"                                                                                                  },
    {".scala", "file_name=%s; cd ${file_name%.*}; sh build.sh"                                                                                           },
    {".sh",    "file_name=%s; sh ${file_name}"                                                                                                           },
    {".sql",   "file_name=%s; mysql -uroot -p < ${file_name}"                                                                                            },
    {".tex",   "file_name=%s; xelatex -interaction nonstopmode ${file_name}; bibtex *.aux; xelatex -interaction nonstopmode ${file_name}; zathura *.pdf" },
    {".ts",    "file_name=%s; tsc ${file_name}"                                                                                                          },
};

/* exec rules for rest */
static const struct KV exec_map_else[] = {
    /**   , shell scripts                  */
    {"*", "file_name=%s; sh ${file_name }" },   // any excuteble file
};

/* default options for cp, mv, rm */
static const char *cp_opt = "-fr"; // recommended "-ir"
static const char *mv_opt = "-f" ; // recommended "-i"
static const char *rm_opt = "-fr"; // recommended "-ir"
