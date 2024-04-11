# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Approach

do_prompt Method:

This method handles the user prompts.
It loops through each question in QUESTIONS, asks the user for input, and validates it.
If the input is not 'yes' or 'no', it asks the question again (redo).
It keeps track of the number of 'yes' answers and calculates the rating based on the total number of questions.
Finally, it returns the calculated rating.

do_report Method:

This method updates the PStore with the new rating and displays a report.
It fetches the current total runs and total ratings from the PStore.
It calculates the new total runs, total ratings (adding the new rating), and the average rating.
Then, it updates the PStore with the new values.
Finally, it displays the total runs and average rating.