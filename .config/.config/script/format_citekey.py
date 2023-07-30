import sys

new_titles = []
with open(sys.argv[1], "r") as f:
    lines = f.readlines()
    ref = author = year = title = ""
    #
    for i in range(len(lines)):
        line = lines[i]
        if line.strip().startswith("@"):
            ref = line.strip()
        elif line.strip().startswith("author"):
            author = line.strip()
        elif line.strip().startswith(("year", "date")):
            year = line.strip()
            print(year)
        elif line.strip().startswith(("title", "booktitle")):
            title = line.strip()

        if ref and author and year and title:
            refindex = ref.index("{")
            refstart = ref[: refindex + 1]

            a = author.split("{")[1].split(",")[0].lower()
            y = year.split("{")[1].split("}")[0][2:4]
            t = (
                title.split("{")[1].split("}")[0].split()[0][:1].lower()
                + title.split("{")[1].split("}")[0].split()[-1][:1].lower()
            )

            nt = refstart + a + y + t + ","
            new_titles.append(nt)

            ref = author = year = title = ""

    j = 0
    for i in range(len(lines)):
        line = lines[i]
        if line.strip().startswith("@"):
            print(new_titles[j].strip())
            j = j + 1
        else:
            print(line.strip())
