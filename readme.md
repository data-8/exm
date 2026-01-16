# Data 8 Typst Library

Templates and formatting for Data 8's Discussion and Tutoring Worksheets, Reference Sheet, Notes and Exams.

#### Features
- automatic point totalling for exams
- multiple choice questions (single select and multiselect, or mix of bubble types)
- answer boxes for long answer questions
- native typst indentation for subquestions
- togglable document modes (print, screen, answer)
- syntax highlighting for code blocks
- custom answer blank for coding questions
- callouts for notes and information boxes

<img width="3825" height="1650" alt="exam" src="https://github.com/user-attachments/assets/bb93ecb5-74d3-4e59-babc-c3e2aef756f5" />
<img width="3825" height="1650" alt="discussions" src="https://github.com/user-attachments/assets/2786d41a-2c73-4c6a-9cbf-f96867118e8c" />

Example PDFs can be found in the [`examples/`](https://github.com/data-8/typst-lib/tree/main/examples) directory.


### Documentation

There are three library files: `utils.typ` which defines the different question components and other niceties, `assignment.typ` which formats for assignment documents (worksheets, notes), and `exam.typ` which formats for exams.

#### Question Components

1. Long answer questions (`#question`)
2. Multiple choice questions (`#mcq`)
3. Answer bank

#### Document Formatting

1. Section
2. Subtitle

#### Info Block/Callout

#### Other Utilities

1. Boxed Math
2. Blank page indicator
3. Next page indicator
4. Code bubble
