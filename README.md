# MATH 6890: Intro to Data-Driven Modeling and Analysis
This is the main repository of course materials for MATH 6890 at RPI, Spring 2026. The syllabus is posted in the README below.
Lecture notes, homework, exams, and supplementary materials will be posted here or linked through Piazza and Gradescope (RCS access only).

> **Course description**
>
> _Given observations of complex phenomena, can we extract information about the underlying laws and principles? Can we use data to improve incomplete models of real-world processes? This course will teach students how to use data to develop and refine models by integrating mathematical tools from classical applied mathematics, probability and statistics, and numerical analysis. Progressing systematically from linear equilibrium phenomena to nonlinear time-dependent processes, students will study the limitations of black-blox prediction algorithms, data-driven paradigms for nonlinear and stochastic modeling, the impact of noisy/corrupted data, and the histeretic influence of unresolved variables. Techniques will be illustrated through both elementary and advanced examples from physics, engineering, biology, and network science._
>
> Prerequisites: A **strong** background in linear algebra is a must. Familiarity with partial differential equations, dynamical systems, and probability at the undergraduate level will be helpful. Course assignments will involve writing code, manipulating data, and testing numerical algorithms (MATLAB, Julia, Python are all acceptable).


## Syllabus

**Lectures**: Tuesday/Friday 10–11:50am in SAGE 2715.

**Instructor**: Andrew Horning

**Office Hours:** 4-5pm on Tuesday / Wednesday in Amos Eaton 329. 

**Contact:** hornia3@rpi.edu

**Course Tools:** Communicate (announcements, questions, and discussion) through [Piazza](https://piazza.com/). View and submit homework assignments on [Gradescope](https://www.gradescope.com/). The final project will be submitted on Gradescope.

**Grading:** 50% homework (4-5 Homeworks), 30% project (due April 22), 20% presentation (April 24 / 27). Problem sets must be submitted to Gradescope before the deadline on the due date. Regrade requests can be made on Gradescope within one week of return.

**Collaboration and Academic Integrity:** To maximize your learning objectives, reserve time to work on each problem independently before discussing it with your classmates. Always write up the solution on your own and acknowledge your collaborators. Copying solutions from peers, books, internet sources, or **AI tools** is strictly prohibited.

**Accomodations and Disability Services:** If you have approved accommodations through the Office of Disability Services for Students ([DSS](https://studenthealth.rpi.edu/list-services/disability-student-services)), please reach out to meet with me early in the semester. We are committed to equal access for all students and will be happy to facilitate the use of approved accommodations. 

## Project

Write a 12-15 page report on a topic (e.g., a problem, technique, or family thereof) in data-driven modeling and analysis. Your report should include:
>
> *Review*: Introduce the topic and explain why it is important. What is its history, and what are
the important publications and references? A comprehensive bibliography is
expected: not just the sources you happened to consult, but a complete set of
sources you would recommend that a reader consult to learn a fuller picture.
>
> *Discussion*: A concise mathematical discussion of the problem(s) and technique(s) you are studying. What is the data that is available? What questions do practitioners want to ask the data? What are the primary modeling ideas used to analyze the data? How does the structure of the data and the nature of the questions inform the modeling choices? What algorithms are used for modeling and analysis?
> 
> *Examples*: Walk through a concrete instance of the problem and illustrate how one or more models and algorithms are used to build models from the data, and extract the required information from the model.
>
The report should be written in clear and concise language at a **level that is accessible to your fellow classmates**. Graphical illustrations of key concepts are highly encouraged when possible.

A list of possible candidates for project topics will be assembled below as the semester progresses, with references to get you started.


## Assignments

- [Homework 1](hw/) is due by 5pm on Friday, February 13. [(Solutions)]()

  
## Lecture summaries

### Lecture 1

- Course logistics and overview
- What makes a mathematical model "good"?
- Where do mathematical models come from?

[Notes](lecture01.pdf)

### Lecture 2

- Data-fitting, prediction, and generalization
- Model recovery and stability
- Example: polynomial interpolation

[Notes](lecture02.pdf)

### Lecture 3

- Fitting a dictionary to data
- Interpolation points and ill-conditioned Vandermonde matrices
- Dictionary choice and stable interpolation algorithms

[Notes](lecture03.pdf) | [Demo](demo01.m) | Read more about polynomial interpolation in this nice [review article](https://doi.org/10.1137/S0036144502417715) (a PDF is available on the second author's [website](https://people.maths.ox.ac.uk/trefethen/papers.html) if you cannot access it through SIAM).

### Lecture 4

- Two-step error analysis of interpolants
- Step 1: Smoothness and convergence rates for "best" approximants
- Step 2: The influence of sample points on the interpolation error

[Notes](lecture04.pdf) | For proofs of Jackson's theorems and more about Lebesgue constants, see these [notes](https://lms.rpi.edu/ultra/courses/_25347_1/cl/outline) on LMS under the "Readings" tab, also available online from UMD's Numerical Analysis course (courtesy of Tobias von Petersdorff). For further reading about polynomial approximation and 1D approximation theory, you may enjoy [six myths about polynomial interpolation](https://doi.org/10.1137/1.9781611975949.appa) (visit the author's website for a free copy of the article) and the [first six chapters](https://people.maths.ox.ac.uk/trefethen/ATAP/) of "ATAP" = Approximation Theory and Approximation Practice. An alternative derivation of convergence rates for Chebyshev interpolants (based on "best" approximations in a different norm) appears in [Chapter 7](https://lms.rpi.edu/ultra/courses/_25347_1/cl/outline) (under Readings on LMS).

### Lecture 5

- Polynomial regression and least-squares
- The power and limitations of oversampling
- Best L2 approximation and weighted least-squares

[Notes](lecture05.pdf) | [Demo](demo02.m) | Check out this [review article](https://doi.org/10.1137/090774707) by Platte, Trefethen, and Kuijlaars for an extensive summary of methods aimed at approximating very smooth functions (analytic) from equispaced data, as well as a fascinating "impossibility" result that captures a fundamental tension between accurate and stable algorithms for equispaced data. (You can find a free pdf of the article at the second author's website under "Papers".) For an approach that optimally balances accuracy and stability, see this [article](https://arxiv.org/abs/2110.03755) by Adcock and Shadrin.


