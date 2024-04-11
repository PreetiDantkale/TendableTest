# Required to use PStore for persistent storage
require "pstore"

# Constants for the PStore file name and the PStore object
STORE_NAME = "tendable.pstore"
$store = PStore.new(STORE_NAME)

# Questions to prompt the user
QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# Method to prompt the user with questions and calculate rating
def do_prompt
  yes_answers = 0
  total_questions = QUESTIONS.size

  # Loop through each question
  QUESTIONS.each_key do |question_key|
    print QUESTIONS[question_key]
    answer = gets.chomp.downcase

    # Validate the user input
    unless ["yes", "no"].include?(answer)
      puts "Invalid input. Please answer with 'yes' or 'no'."
      redo  # Ask the same question again
    end

    # Count 'yes' answers
    yes_answers += 1 if answer == "yes"
  end

  # Calculate rating based on 'yes' answers
  rating = (yes_answers.to_f / total_questions) * 100
  puts "Rating for this run: #{rating.round(2)}%"
  rating  # Return the calculated rating
end

# Method to update PStore with new rating and display total runs and average rating
def do_report(rating)
  $store.transaction do
    # Fetch current total runs and total ratings from PStore, defaulting to 0 if not found
    total_runs = $store.fetch(:total_runs, 0)
    total_ratings = $store.fetch(:total_ratings, 0)

    # Calculate new total runs and total ratings
    total_runs += 1
    total_ratings += rating

    # Calculate average rating
    average_rating = total_ratings.to_f / total_runs

    # Update PStore with new values
    $store[:total_runs] = total_runs
    $store[:total_ratings] = total_ratings

    # Display total runs and average rating
    puts "Total Runs: #{total_runs}"
    puts "Average Rating: #{average_rating.round(2)}%"
  end
end

# Main loop to keep prompting the user until they choose to stop
loop do
  rating = do_prompt  # Prompt the user and get rating
  do_report(rating)  # Update PStore and display report
  puts "Would you like to do another run? (yes/no)"
  response = gets.chomp.downcase
  break if response != "yes"  # Break the loop if user does not want another run
end
