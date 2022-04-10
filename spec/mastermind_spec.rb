require_relative '../lib/main'


    describe Game do
        subject { Game.new }

        describe '#check_spelling' do
            it "checks for typing error of colors" do
                expect(subject.check_spelling(['blue','bleu','red','red'])).to eql(subject.play) 
            end

            it "checks for correct typing of colors" do
                expect(subject.check_spelling(['blue','blue','red','red'])).to eql(subject.response) 
            end
        end

    end
