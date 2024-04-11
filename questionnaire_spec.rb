require_relative 'questionnaire'

RSpec.describe "CodeToTest" do
  describe "#do_prompt" do
    context "with valid answers" do
      before do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("yes", "yes", "yes", "yes", "yes")
      end

      it "returns 100.0%" do
        expect(do_prompt).to eq(100.0)
      end
    end

    context "with no answers" do
      before do
        allow_any_instance_of(Kernel).to receive(:gets).and_return("yes", "yes", "no", "yes", "yes")
      end

      it "returns 80.0% and shows error message" do
        expect(do_prompt).to eq(80.0)
      end
    end
  end

  describe "#do_report" do
    it "updates total runs and average rating" do
      allow($store).to receive(:transaction).and_yield
      allow($store).to receive(:fetch).with(:total_runs, 0).and_return(10)
      allow($store).to receive(:fetch).with(:total_ratings, 0).and_return(850)
      allow($store).to receive(:[]=)
      expect { do_report(85.0) }.to output("Total Runs: 11\nAverage Rating: 85.0%\n").to_stdout
    end
  end
end
