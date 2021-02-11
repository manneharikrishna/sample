shared_examples RetryableJob do
  context 'when an error is raised' do
    before do
      allow_any_instance_of(described_class).to receive(:perform).
        and_raise(StandardError)
    end

    it 'retries the job' do
      assert_performed_jobs(5) do
        described_class.perform_later rescue nil
      end
    end
  end
end
