vorg 
====
The plain text organizer for ViM

Format
------
The vorg format is designed to be easy on the eyes and readable
in any text editor. 

```
- Today 
  - [ ] Call Tom <office> <2m>
  - [ ] Pick-up my laundry <car> <30m>
- Someday
  - [ ] Read "Getting Things Done" <book>
  - [ ] Watch "Men Of Valor" <movie>
- Projects
  - Setup my Blog
    - [x] Choose blogging software <1h>
    - [ ] Choose a hosting provider <30m>
    - [ ] Design my template <3h>
    - [ ] Write my first post <puter> <1h>
  - Trip to Italy
    - [x] Gather sites <puter> <1h>
    - [x] Plan route <puter> <30m>
    - [ ] Book an apartment <puter> <30m>
    - [ ] Rent a car
    - [ ] Reserve flights
- Logbook
  - 2012-10-23 @ 12:00 | Found a nice CSS tool <tools>
```

### Sections and Tasks
Vorg is a hierarchical file format. You organize
your notes, tasks and text in sections, sub-sections,
sub-sub-sections etc.
Tasks are a special kind of sections. Tasks can be marked
done and are prioritized based on their order.

```
- Section
  - Sub-Section
     - [ ] First Priority Task
     - [x] Second Priority Task
```

### Indentation
A valid vorg file uses (exactly) 2 spaces to indent items. This scheme ensures your files will be readable in any editor.
This is not a technical constraint. It is an aesthetic constraint designed to make sure vorg files are easy to read.

### Free Text
Sections and tasks can contain any number of lines of free text aligned
with the section title.

```
- Section
  - Sub-Section
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore 
    magna aliqua. 
```

### Tags
Sections and tasks can be tagged. Tags can be used to indicate context
or category and are important when you need to gather items from
a large set of long vorg files.

```
- Section <tag1> <tag2>
  - [ ] My Task <tag3>
```

Shortcuts
---------
The ViM plugin have the following keyboard shortcuts predefined:

### insert mode
- **--** indent and begin a new section
- **-=** indent and begin a new task
- **`** add a new tag (without moving or typing the markup)

### normal mode
- **TAB** : fold or unfold a section
- **==**  : check a task checkbox
- **--**  : uncheck a task checkbox
- **CTRL+k** : move a line up
- **CTRL+j** : move a line down
