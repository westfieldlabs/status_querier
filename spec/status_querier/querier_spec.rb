module StatusQuerier
  RSpec.describe Querier do
    class TestModel < ::ActiveRecord::Base
      SUPPORTED_STATUSES.each do |method_name|
        define_singleton_method method_name do
          self
        end
      end

      def self.or(_)
        self
      end
    end

    class TestModelWithMissingStatuses
      # Missing some status implmentation
      SUPPORTED_STATUSES[0..2].to_a.each do |method_name|
        define_singleton_method method_name do
          self
        end
      end

      def self.or(_)
        self
      end
    end

    before(:all) do
      TestModel.include(Querier)
      TestModelWithMissingStatuses.include(Querier)
    end

    it "joins #{SUPPORTED_STATUSES.join(', ')} with where-or#or" do
      chainable_relation = TestModel
      SUPPORTED_STATUSES.each do |status|
        expect(TestModel).to receive(status).and_return(chainable_relation)
      end

      # s1 | s2 | s3 | s4 | s5 | s6 - or gets called only 1 less than length of array
      call_count = SUPPORTED_STATUSES.size - 1

      expect(chainable_relation).to receive(:or).with(chainable_relation).exactly(call_count).times.and_return(chainable_relation)

      TestModel.with_any_statuses(SUPPORTED_STATUSES)
    end

    it 'raises Error::InvalidStatus with unsupported status' do
      expect { TestModel.with_any_statuses(['whatisthis']) }.to raise_error(Error::InvalidStatus)
    end

    it 'raises NotImplementedError when calling unimplemented supported status' do
      status = SUPPORTED_STATUSES.last
      expect { TestModelWithMissingStatuses.with_any_statuses([status]) }.to raise_error(NotImplementedError)
    end
  end
end
