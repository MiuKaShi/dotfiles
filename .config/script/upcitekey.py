#!/bin/python

import argparse
import bibtexparser
import sys
import os
import re
from collections import OrderedDict


def splitNames(name_str):
    name_str = name_str.lower().replace(" and ", ", ")
    ret = name_str.split(", ")
    return ret


def remove_special_chars(s):
    special_chars = [
        "\\",
        "'",
        "<i>",
        "</i>",
        " textasciidieresis",
        "<",
        ">",
        "{",
        "}",
        "(",
        ")",
    ]
    for char in special_chars:
        s = s.replace(char, "")
    return s


def fixKey(ent, verbose=False):
    try:
        cleaned_author = remove_special_chars(ent["author"])
        print(cleaned_author)
        names = splitNames(cleaned_author)[0].split(" ")[0]
        cleaned_title = remove_special_chars(ent["title"])
        title = (
            cleaned_title.split()[0][:1].lower() + cleaned_title.split()[-1][:1].lower()
        )
        key = "{}{}{}".format(names, ent["year"][2:4], title)
    except KeyError:
        if verbose:
            sys.stderr.write("WARN: Could not find author field for entry!")
            for k, v in ent.items():
                sys.stderr.write("\n\t{}: {}".format(k, v))
            sys.stderr.write("\n")
        key = ent["ID"]
    return key


def refEqual(rhs, lhs):
    try:
        for key in rhs.keys():
            if rhs[key] != lhs[key]:
                return False
    except KeyError:
        return False
    return True


def main():
    parser = argparse.ArgumentParser(
        description="Replace BibTex keys with [author][year][title]."
    )

    parser.add_argument(
        "-o",
        "--ofname",
        default="",
        help="Name of file to write. If this argument is left out, in_file is rewritten.",
    )

    parser.add_argument(
        "-a",
        "--alphabetize",
        default=False,
        action="store_true",
        help="Should entries in new bib be alphabetized? Default is false.",
    )

    parser.add_argument(
        "-k",
        "--allKeys",
        default=False,
        action="store_true",
        help='Remake all keys? By default only those that match the regex "RN[0-9]+" are replaced.',
    )

    parser.add_argument(
        "-v", "--verbose", choices=[0, 1], default=0, help="Verbose output?"
    )

    parser.add_argument("in_file", help="Name of file to read.")

    args = parser.parse_args()

    with open(args.in_file, "r") as bibtex_file:
        bibDatabase = bibtexparser.load(bibtex_file)

    reset_key_re = re.compile(r"RN[0-9]+")
    new_bib = OrderedDict()
    for ent in bibDatabase.entries:
        if reset_key_re.match(ent["ID"]) or args.allKeys:
            key = fixKey(ent, args.verbose)
            ent["ID"] = key
        else:
            key = ent["ID"]
        if key in new_bib:
            if refEqual(ent, new_bib[key]):
                if args.verbose:
                    sys.stderr.write("WARN: found duplicate entries!")
                    for k, v in ent.items():
                        sys.stderr.write("\t{}: {}, {}\n".format(k, v, new_bib[key][k]))

            else:
                for i in range(ord("a"), ord("z")):
                    new_key = "{}{}".format(key, chr(i))
                    if new_key not in new_bib:
                        ent["ID"] = new_key
                        key = new_key
                        break
                if ent["ID"] in new_bib:
                    raise RuntimeError(
                        "Ran out of possible key postfixes:\n\t{}\n".format(ent)
                    )
        new_bib[key] = ent

    if args.ofname == "":
        ofname = args.in_file
    else:
        ofname = args.ofname

    # make new bib db
    db = bibtexparser.bibdatabase.BibDatabase()
    db.entries = list(new_bib.values())

    # write new db
    writer = bibtexparser.bwriter.BibTexWriter()
    if not args.alphabetize:
        writer.order_entries_by = None
    with open(ofname, "w") as bibfile:
        bibfile.write(writer.write(db))


if __name__ == "__main__":
    main()
