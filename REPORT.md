# REPORT.md - Operating Systems Programming Assignment 01

## Feature 2: Multi-file Project using Make Utility

**Q1: Explain the linking rule in this part's Makefile: $(TARGET): $(OBJECTS). How does it differ from a Makefile rule that links against a library?**

This rule tells make that the final executable ($(TARGET)) depends on all the object files ($(OBJECTS)) being up to date. The command $(CC) $(OBJ) -o $(TARGET) links all object files directly together into one executable, combining every function's compiled code at link time. In contrast, a rule that links against a library only lists main.o as a direct dependency, plus the library file itself, and uses -L and -l flags to tell the linker where to find and pull in only the specific functions actually used, rather than explicitly listing every object file.

**Q2: What is a git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?**

A git tag is a fixed, permanent label attached to a specific commit, marking it as a significant point in the project's history, typically a release version. Tags are useful because they let you instantly reference or return to a known stable state without remembering a commit hash. A simple tag is just a name pointing to a commit with no extra metadata. An annotated tag (created with -a) is a full Git object that also stores the tagger's name, email, date, and a message, making it the recommended standard for official releases.

**Q3: What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries to it?**

A GitHub Release packages a specific tagged version of the project into a user-friendly, downloadable format along with release notes describing what changed. Attaching binaries lets users run the program immediately without needing to clone the repository and compile the source code themselves, which is how most software is distributed to end users in practice.

## Feature 3: Creating and using Static Library

**Q1: Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?**

Part 2's Makefile links the executable directly from all .o files in one step, with no library involved. Part 3's Makefile introduces a new target that builds a static library (lib/libmyutils.a) using the ar command, and changes the final executable's rule to link only main.o against that library using LIBFLAGS = -Llib -lmyutils. This adds an extra build stage and separates library code from driver code into two independent build products.

**Q2: What is the purpose of the ar command? Why is ranlib often used immediately after it?**

ar (archiver) bundles multiple object files into a single static library archive file, acting like a container the linker can pull specific object files from. ranlib generates or refreshes an index inside that archive listing which symbols are defined in which object files, letting the linker quickly locate needed functions. The s flag in ar rcs performs this same indexing automatically, which is why a separate ranlib call is often not strictly necessary in modern usage.

**Q3: When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?**

Yes, running nm on client_static showed mystrlen defined (marked T) directly inside the executable at a real memory address. This confirms that static linking physically copies the actual machine code for each used function out of the library archive and embeds it directly into the final executable, making the executable fully self-contained with no runtime dependency on libmyutils.a.

## Feature 4: Creating and using Dynamic Library

(To be completed after building Feature 4)

## Feature 5: Creating and Accessing Man Pages

(No report questions specified for this feature)
