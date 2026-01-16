# Data 8 Typst Library

Templates and formatting for Data 8's Discussion and Tutoring Worksheets, Reference Sheet, Notes and Exams.

## Features
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

<hr>

# Documentation

There are three library files: `utils.typ` which defines the different question components and other niceties, `assignment.typ` which formats for assignment documents (worksheets, notes), and `exam.typ` which formats for exams.

## Question Components

### 1. **Long answer questions (`#question`)**

```typst
#question(ansbox, height, ansheight, ansalign, points)[<question>][<answer>]
````

**Parameters**
- **`question`** (`content`, required): question statement
- **`answer`** (`content`, required): answer content
- **`ansbox`** (`bool`, default: `false`): draw a box underneath the question
- **`height`** (`length | auto`, default: `auto`): height of the entire question block
- **`ansheight`** (`length | auto`, default: see notes below): height of the entire question when the answer is shown
- **`ansalign`** (`alignment`, default: `horizon`): alignment of the content
- **`points`** (`float`, default: `""`): points assigned to the question

> **Example**
> ```typst
> #question(ansbox: true, ansheight: 3cm, points: 4.0)[
>    What is $2 + 2$? Write a statement to evaluate in Python.
>    // since this is just Typst content, it can be anything (could include tables, math, images, code blocks, etc...)
> ][
>    `2 + 2  # 4`
> ]
> ```
> 
> Without answer shown: <br>
    <img width="768" height="110" alt="Screenshot 2026-01-17 at 11 58 17" src="https://github.com/user-attachments/assets/e226df70-660b-4ea2-aad4-cdaf18abdac0" /> <br>
> With answer shown: <br>
    <img width="768" height="110" alt="Screenshot 2026-01-17 at 11 58 42" src="https://github.com/user-attachments/assets/e479fb8b-be28-406a-ab85-1ef1d0dba9be" />

**Notes**

- when the answer box is *not* shown, the default `ansheight` is auto (fits to content). When the answer box is shown, the default `ansheight` is the same as the height defined.
  - you may override `ansheight` to your liking if you don't want this behaviour

<br>
   
### **2. Multiple choice questions (`#mcq`)**

```typst
#mcq(question, choices, answer, 
     cols, multi,
     ansbox, height, ansheight, ansalign, explanation, points)
````

**Parameters**
- **`question`** (`content`, required): question statement
- **`choices`** (array of `content`, required): choices
- **`answer`** (`int` or array of `int`): **index** (0-indexed) of correct answer choice OR array of correct answer choices
- **`cols`** (`int` or array of `length`, default: `1`): number of answer choice columns. defaults to `1` so options are shown vertically. For horizontal use column count equivalent to number of choices. You may also specify array of lengths, where each length corresponds to the length of that choice displayed horizontally
- **`multi`** (`bool` or array of `bool`, default: `false`): display box as square (multi = `true`) or circle (multi = `false`). You may specify an array of booleans to customise each bubble
- **`explanation`** (`content`, default: `""`): an explanation of the selected answer option displayed underneath the question. Only shown when answers are shown
- **`ansbox, height, ansheight, ansalign, points`**: same as `#question` (see above)


> **Example**
> ```typst
> #mcq([What will the following Python expression be equivalent to?
>      #align(center)[`2 + 2`]
>     ], (
>        `4`,
>         `len(np.array([1, 2, 3, 4]))`,
>        `2`,
>        `6`,
>       "None of the above"
>     ),
>     (0, 1),
>     points: 3.0,
>     multi: (true, true, true, true, false)
> )
> 
> With answer shown: <br>
    <img width="768" height="186" alt="Screenshot 2026-01-17 at 12 13 59" src="https://github.com/user-attachments/assets/193c19fc-b8bd-47f2-a370-c1100f29b107" />



### **3. Answer bank**


### Document Formatting

1. Section
2. Subtitle

### Info Block/Callout

### Other Utilities

1. Boxed Math
2. Blank page indicator
3. Next page indicator
4. Code bubble
